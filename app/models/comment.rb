class Comment < ActiveRecord::Base
  # belongs_to :user
  # belongs_to :bookmark
  # belongs_to :language
  belongs_to :commentable, :polymorphic => true
  belongs_to :user
  #has_many :codes
  
#   syntaxify :body, :line_numbers => :table, :css => :class
# begin 
#   define_index do
#     # fields
#     indexes title
#     indexes body, :as => :description
#     
#     # attributes
#     has user_id, bookmark_id, language_id, created_at, updated_at
#   end
# end
end




# == Schema Information
#
# Table name: comments
#
#  id               :integer(4)      not null, primary key
#  body             :text
#  created_at       :datetime
#  updated_at       :datetime
#  commentable_id   :integer(4)
#  commentable_type :string(255)
#  name             :string(255)
#  email            :string(255)
#

