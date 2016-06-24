class RemoveAvatarFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :avatar
    remove_column :users, :name
  end
end
