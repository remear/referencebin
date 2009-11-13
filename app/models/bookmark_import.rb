class BookmarkImport < ActiveRecord::Base
  belongs_to :language
  belongs_to :user
  
  acts_as_taggable_on :topic
  #attr_accessible :title, :url, :user_id, :description, :language_id
  
  validates_uniqueness_of :url
  
  def self.per_page
    40
  end
end
