class RenameUsersInBaskets < ActiveRecord::Migration[6.0]
  def change
    rename_column :baskets, :users, :user
  end
end
