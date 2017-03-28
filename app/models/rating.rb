class Rating < ActiveRecord::Base
  belongs_to :portfolio
  validates :rating, presence: true;
  validates_inclusion_of :rating, :in => 1..10;
  validates :user_id, presence: true;
  validates :portfolio_id, presence: true;
end
