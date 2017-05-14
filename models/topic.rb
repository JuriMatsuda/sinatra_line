class Topic < ActiveRecord::Base
  has_many :user_topics, dependent: :delete_all
  has_many :users, through: :user_topics
  has_many :comments
end