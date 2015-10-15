class User < ActiveRecord::Base
  has_secure_password

  validates_presence_of :username, on: :create
  validates_uniqueness_of :username, on: :create
  validates_presence_of :password, on: :create

  def password=(secret)
    write_attribute(:password, BCrypt::Password.create(secret))
  end

  def self.authenticate_with_password!(user, attempt)
    user && Bcrypt::Password.new(user.password) == attempt
  end
end
