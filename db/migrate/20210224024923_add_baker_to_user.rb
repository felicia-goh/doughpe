class AddBakerToUser < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :role
    add_column :users, :baker, :boolean, default: false
  end
end
