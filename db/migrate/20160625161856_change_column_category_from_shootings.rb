class ChangeColumnCategoryFromShootings < ActiveRecord::Migration
  def change
    change_column :shootings, :category, :integer
  end
end
