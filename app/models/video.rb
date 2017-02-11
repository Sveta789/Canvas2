class Video < ActiveRecord::Base
  belongs_to :user
  has_attached_file :video, processors: lambda { |a| a.is_video? ? [ :ffmpeg ] : [ :thumbnail ] }
  validates :user_id, presence: true
  validates :category, presence: true

end
