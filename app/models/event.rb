class Event < ActiveRecord::Base
  belongs_to :admin
  mount_uploader :image, ImageUploader
  validates :admin_id, presence: true
  validates :title, presence: true
  validates :body, presence: true
  validates :category, presence: true
end
