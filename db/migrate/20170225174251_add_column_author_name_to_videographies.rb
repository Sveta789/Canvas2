class AddColumnAuthorNameToVideographies < ActiveRecord::Migration
  def change
    add_column :videographies, :author_name, :string
    remove_column :videographies, :image
  end
end
