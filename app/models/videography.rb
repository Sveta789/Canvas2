class Videography < ActiveRecord::Base
  belongs_to :user
  include Filterable
  include ApplicationHelper
  validates :category, presence: true,
            inclusion: { in: ApplicationHelper.get_video_categories}
  validates :user_id, presence: true
  validates :price, presence: true

  scope :author_name, -> (author_name) {
    if author_name == ''
      all
    else
      where("lower(author_name) like ?", "%#{author_name.mb_chars.downcase.to_s}%")
    end
  }
  scope :category, -> (category) {
    if category == 'Все'
      all
    else
      where category: category
    end
  }
  scope :price, -> (price) { where("price >= ? and price <= ?", "#{price['min']}%", "#{price['max']}%") }
end
