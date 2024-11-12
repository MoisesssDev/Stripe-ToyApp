class CreateExperiences < ActiveRecord::Migration[7.2]
  def change
    create_table :experiences do |t|
      t.references :store, null: false, foreign_key: true
      t.string :title

      t.timestamps
    end
  end
end
