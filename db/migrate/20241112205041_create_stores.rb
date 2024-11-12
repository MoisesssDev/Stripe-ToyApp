class CreateStores < ActiveRecord::Migration[7.2]
  def change
    create_table :stores do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.string :stripe_account_id
      t.boolean :charges_enabled
      t.boolean :payouts_enabled

      t.timestamps
    end
  end
end
