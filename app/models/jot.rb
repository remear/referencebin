# == Schema Information
#
# Table name: jots
#
#  id          :integer(4)      not null, primary key
#  user_id     :integer(4)
#  language_id :integer(4)
#  private     :boolean(1)
#  code        :text
#  error       :text
#  created_at  :datetime
#  updated_at  :datetime
#

class Jot < ActiveRecord::Base
  attr_accessible :code, :error, :language_id
  belongs_to :language
  
  validates_presence_of :language_id
  validates_presence_of :code
  
  syntaxify :body, :line_numbers => :table, :css => :class
end
