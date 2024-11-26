class RemoveBookingFromBatches < ActiveRecord::Migration[7.2]
  def change
    remove_column :batches, :booking_id, :integer
  end
end
