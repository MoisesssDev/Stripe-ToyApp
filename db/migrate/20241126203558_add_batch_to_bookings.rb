class AddBatchToBookings < ActiveRecord::Migration[7.2]
  def change
    add_reference :bookings, :batch, null: false, foreign_key: true
  end
end
