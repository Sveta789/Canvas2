class AddColumnCategoryToPhoto < ActiveRecord::Migration
  def change
    add_column :photos, :category, :string
  end
end
