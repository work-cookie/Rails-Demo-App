class User < ApplicationRecord
  has_many :microposts
  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255}, format: {with: VALID_EMAIL_REGEX},
            uniqueness: {case_sensitive: false}

  before_save { email.downcase!}

  has_secure_password

  validates :password, presence: true, length: {minimum: 6}

  #Gives the hash of password
  def User.digest(password)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(password, cost: cost)
  end

end
