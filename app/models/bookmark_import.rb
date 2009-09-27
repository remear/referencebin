class BookmarkImport < ActiveRecord::Base
  attr_accessible :title, :url, :user_id, :description, :language_id
  
  validates_uniqueness_of :url
  
  def self.per_page
    40
  end
end
