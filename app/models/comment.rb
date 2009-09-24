class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :bookmark
  belongs_to :language
  has_many :codes
  
  syntaxify :body, :line_numbers => :table, :css => :class
end
