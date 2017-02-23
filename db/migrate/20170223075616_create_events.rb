class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.string :summary
      t.string :body
      t.integer :admin_id
      t.string  :image
      t.string :category
      t.timestamps null: false
    end
  end
end
