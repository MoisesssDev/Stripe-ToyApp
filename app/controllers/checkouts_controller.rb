class CheckoutsController < ApplicationController
  before_action :set_batch, only: [ :create ]

  def create
    store = @batch.experience.store

    if store.stripe_account_id.blank? || !store.charges_enabled
      render json: { error: "Store is not configured for payments" }, status: :unprocessable_entity
    end

    session = Stripe::Checkout::Session.create(
      payment_method_types: [ "card" ],
      line_items: [ {
        price_data: {
          currency: "brl",
          product_data: {
            name: @batch.experience.title
          },
          unit_amount: @batch.price
        },
        quantity: 1
      } ],
      mode: "payment",
      success_url: experience_url(@batch.experience), # Redirecionamento após sucesso
      cancel_url: experience_url(@batch.experience),  # Redirecionamento após cancelamento
      payment_intent_data: {
        application_fee_amount: (@batch.price * 0.85).to_i, # Taxa de 15% para o marketplace
        transfer_data: {
          destination: store.stripe_account_id # Conta Stripe do parceiro
        }
      }
    )

    Booking.find_or_create_by(user: current_user, batch: @batch, status: :pending)

    redirect_to session.url, status: :see_other, allow_other_host: true
  end

  private

  def set_batch
    @batch = Batch.find(params[:batch_id])
  end
end