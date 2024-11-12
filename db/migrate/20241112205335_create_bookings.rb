class CreateBookings < ActiveRecord::Migration[7.2]
  def change
    create_table :bookings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :experience, null: false, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
