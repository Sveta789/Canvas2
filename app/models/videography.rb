class Videography < ActiveRecord::Base
  belongs_to :user
  has_one :profile, :through => :user
  has_one :portfolio, :through => :user
  has_many :ratings, :through => :portfolio
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
      joins(:profile).where("(lower(profiles.name) || ' ' || lower(profiles.surname)) like ?", "%#{author_name.mb_chars.downcase.to_s}%")
    end
  }
  scope :category, -> (category) {
      where category: category
  }
  scope :price, -> (price) { where("price >= ? and price <= ?", "#{price['min']}", "#{price['max']}") }

  scope :sort_it, -> (sorter) {
    case sorter
      when :price
        order(:price)
      when :category
        order(:category)
      when :popularity
        joins(:ratings).order("ratings.rating DESC")
      else
        order(:price)
    end
  }
end
