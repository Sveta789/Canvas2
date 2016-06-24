class Photo < ActiveRecord::Base
  belongs_to :user
  mount_uploader :image, ImageUploader
  validates :user_id, presence: true

end
