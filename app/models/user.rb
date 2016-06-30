class User < ActiveRecord::Base

  before_save { self.email = email.downcase }
  before_create :create_remember_token
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
      uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }

  has_many :photos
  has_many :shootings
  has_many :videos
  has_many :videographies
  has_one :portfolio
  has_one :profile

  after_create :create_portfolio
  after_create :create_profile




  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

  def create_remember_token
    self.remember_token = User.encrypt(User.new_remember_token)
  end

  def create_portfolio
    Portfolio.create(user_id: self.id, description: "Portfolio of member #{self.email}")
  end

  def create_profile
    Profile.create(user_id: self.id)
  end
end
