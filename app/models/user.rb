class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable

  # def after_confirmation
  #   redirect_to self.profile
  # end

  # before_save { self.email = email.downcase }
  # before_create :create_remember_token
  # VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  # validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
  #     uniqueness: { case_sensitive: false }
  # validates :password, length: { minimum: 6 }

  # validates :email, presence: true, length: { minimum: 6 }, on: :create
  # validates :password, presence: true, length: { minimum: 6 }, on: :create

  has_many :photos
  has_many :shootings
  has_many :videos
  has_many :videographies
  has_many :comments
  has_many :ratings
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
