# == Schema Information
#
# Table name: bookmark_imports
#
#  id          :integer(4)      not null, primary key
#  title       :string(255)
#  url         :string(255)
#  user_id     :integer(4)
#  description :string(255)
#  language_id :integer(4)
#  created_at  :datetime
#  updated_at  :datetime
#

class BookmarkImport < ActiveRecord::Base
  belongs_to :language
  belongs_to :user
  
  acts_as_taggable_on :topics, :questions
  #attr_accessible :title, :url, :user_id, :description, :language_id
  
  validates_uniqueness_of :url
  
  def self.per_page
    40
  end
end
