class Jot < ActiveRecord::Base
  attr_accessible :body, :error
  belongs_to :language
  
  validates_presence_of :language_id
  validates_presence_of :code
  
  syntaxify :body, :line_numbers => :table, :css => :class
end
