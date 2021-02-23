class AddColumnsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :username, :string
    add_column :users, :name, :string
    add_column :users, :bio, :text
    add_column :users, :role, :string
    add_column :users, :address, :string
  end
end
