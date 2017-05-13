class User < ActiveRecord::Base
  has_many :comments
  validates :name, presence: true
  validates :password, presence: true
  has_secure_password
end
