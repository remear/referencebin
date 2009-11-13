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
