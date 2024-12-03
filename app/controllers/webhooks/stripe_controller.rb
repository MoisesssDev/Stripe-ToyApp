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
      return
    end

    case event.type
    when "account.updated"
      handle_account_updated(event.data.object)
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
end
