class User < ActiveRecord::Base
  has_many :user_topics
  has_many :topics, through: :user_topics
  has_many :comments

  validates :name, presence: true
  validates :password, presence: true
  has_secure_password
end
