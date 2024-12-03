class Webhooks::StripeController < Webhooks::BaseController
  def create
    payload = request.body.read
    event = nil
    Rails.logger.info "#####################  WEBHOOK RECEIVED: #{payload} ############################"

    begin
      event = Stripe::Event.construct_from(
        JSON.parse(payload, symbolize_names: true)
      )
    rescue JSON::ParserError => e
      # Invalid payload
      puts "⚠️  Webhook error while parsing basic request. #{e.message})"
      render json: { message: "failed" }, status: 400
    end

    case event.type
    when "account.updated"
      handle_account_updated(event.data.object)
    when "checkout.session.completed"
      handle_checkout_session_completed(event.data.object)
    else
      puts "Unhandled event type: #{event.type}"
    end

    render json: { message: "success" }
  end

  private

  def handle_account_updated(account)
    store = Store.find_by(stripe_account_id: account.id)
    store.update(
      charges_enabled: account.charges_enabled,
      payouts_enabled: account.payouts_enabled
    )
  end

  def handle_checkout_session_completed(session)
    batch = Batch.find(session.metadata.batch_id)
    user = User.find(session.metadata.user_id)

    booking = Booking.create!(batch: batch, user: user, stripe_payment_intent_id: session.payment_intent)
    booking.save!
    Rails.logger.info "✅ Booking created for CheckoutSession #{session.id}"
  end
end
