class User < ActiveRecord::Base
  has_many :hospitals
  has_secure_password
  validates :username, uniqueness: true
  validates :email, uniqueness: true
end