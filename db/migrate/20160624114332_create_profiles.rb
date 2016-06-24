class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :surname
      t.string :sex
      t.date :birthday
      t.string :city
      t.string :avatar
      t.string :phone_number
      t.string :social_email
      t.string :social_network
      t.string :hobby
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
