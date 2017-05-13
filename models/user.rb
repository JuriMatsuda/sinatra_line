class User < ActiveRecord::Base
  has_many :users_topics
  has_many :comments, through: :users_topics

  validates :name, presence: true
  validates :password, presence: true
  has_secure_password
end
