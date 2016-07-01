class ChangeColumnCategoryFromShootings2 < ActiveRecord::Migration
    def change
      change_column :shootings, :category, :string
    end
end
