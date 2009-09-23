class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :bookmark
  
  syntaxify :body, :line_numbers => :table, :css => :class
end
