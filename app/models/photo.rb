class Photo < ActiveRecord::Base
  belongs_to :user
  mount_uploader :image, ImageUploader
  validates :path, presence: true

end
