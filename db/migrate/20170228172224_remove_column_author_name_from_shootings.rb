class RemoveColumnAuthorNameFromShootings < ActiveRecord::Migration
  def change
    remove_column :shootings, :author_name
  end
end
