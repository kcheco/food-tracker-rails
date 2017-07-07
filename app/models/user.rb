class User < ApplicationRecord
  # encrypt passwords
  has_secure_password

  #validations
  validates_presence_of :name, :email, :password_digest
  validates_uniqueness_of :email
end
