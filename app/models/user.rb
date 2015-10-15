class User < ActiveRecord::Base
  after_initialize :_set_defaults
  validates_presence_of :username, on: :create
  validates_uniqueness_of :username, on: :create
  validates_presence_of :password, on: :create

  def password=(password)
    write_attribute(:password, BCrypt::Password.create(password))
  end

  private

  def _set_defaults
    self.api_secret ||= MicroToken.generate(128)
  end
end
