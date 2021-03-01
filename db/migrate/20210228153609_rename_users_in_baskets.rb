class RenameUsersInBaskets < ActiveRecord::Migration[6.0]
  def change
    rename_column :baskets, :users_id, :user_id
  end
end
