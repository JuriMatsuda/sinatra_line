class User < ActiveRecord::Base
  has_many :users_topics, dependent: :delete_all
  has_many :user, through: :users_topics
  has_many :comments
end
