class RefundsController < ApplicationController
  def create
    booking = Booking.find(params[:booking_id])

    Stripe::Refund.create({
      payment_intent: booking.stripe_payment_intent_id,
      amount: booking.batch.price,
      reason: "requested_by_customer"
    })

    redirect_to bookings_path
  end
end
