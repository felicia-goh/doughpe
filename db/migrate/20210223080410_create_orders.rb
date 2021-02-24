class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.references :slot, null: false, foreign_key: true
      t.string :delivery_method
      t.string :delivery_address
      t.string :status
      t.float :total
      t.integer :quantity

      t.timestamps
    end
  end
end
