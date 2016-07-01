class CreateVideographies < ActiveRecord::Migration
  def change
    create_table :videographies do |t|
      t.string :category
      t.float :price
      t.string :image
      t.string :description
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
