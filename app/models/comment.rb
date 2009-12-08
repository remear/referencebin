# == Schema Information
#
# Table name: comments
#
#  id          :integer(4)      not null, primary key
#  user_id     :integer(4)
#  bookmark_id :integer(4)
#  language_id :integer(4)
#  title       :string(255)
#  body        :text
#  importance  :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :bookmark
  belongs_to :language
  has_many :codes
  
  syntaxify :body, :line_numbers => :table, :css => :class
begin 
  define_index do
    # fields
    indexes title
    indexes body, :as => :description
    
    # attributes
    has user_id, bookmark_id, language_id, created_at, updated_at
  end
end
end
