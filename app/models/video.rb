class Video < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :category, presence: true
  validates :path, presence: true

end
