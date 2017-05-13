class UserTopic < ActiveRecord::Base
  self.table_name = 'users_topics'

  belongs_to :user
  belongs_to :topic
end