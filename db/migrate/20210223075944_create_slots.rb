class CreateSlots < ActiveRecord::Migration[6.0]
  def change
    create_table :slots do |t|
      t.date :date
      t.integer :available_quantity
      t.string :time_period
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
