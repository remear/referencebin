class Code < ActiveRecord::Base
  belongs_to :user
  belongs_to :comment
  belongs_to :language
  
  syntaxify :code, :line_numbers => :table, :css => :class
end
