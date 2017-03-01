class RemoveColumnAuthorNameFromVideographies < ActiveRecord::Migration
  def change
    remove_column :videographies, :author_name
  end
end
