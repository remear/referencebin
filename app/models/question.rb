class Question < ActiveRecord::Base
  belongs_to :user
  belongs_to :bookmark
  belongs_to :language
  belongs_to :code

  attr_accessible :body, :user_id, :bookmark_id, :count
end
