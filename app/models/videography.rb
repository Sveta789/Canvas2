class Videography < ActiveRecord::Base
  belongs_to :user
  validates :category, presence: true
  validates :user_id, presence: true
  validates :price, presence: true
end
