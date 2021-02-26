class ChangeOrders < ActiveRecord::Migration[6.0]
  def change

    create_table :baskets do |t|
      t.boolean :completed
      t.float :total
      t.references :users
      t.timestamps
    end

    remove_column :orders, :status, :string
    add_column :orders, :delivered, :boolean, default: false
    add_column :orders, :time_period, :string
    rename_column :orders, :total, :subtotal
    add_reference :orders, :basket, foreign_key: true

    remove_column :slots, :time_period, :string
  end
end
