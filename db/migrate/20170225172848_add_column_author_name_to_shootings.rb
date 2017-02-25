class AddColumnAuthorNameToShootings < ActiveRecord::Migration
  def change
    add_column :shootings, :author_name, :string
    remove_column :shootings, :image
  end
end
