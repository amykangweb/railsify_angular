class User < ActiveRecord::Base
  has_secure_password

  validates_presence_of :username, on: :create
  validates_uniqueness_of :username, on: :create
  validates_presence_of :password, on: :create

  def password=(secret)
    self.password_digest = BCrypt::Password.create(secret)
  end

  def self.authenticate_with_password!(user, attempt)
    user.authenticate(attempt) == false ? false : true
  end
end
