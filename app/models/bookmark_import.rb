class BookmarkImport < ActiveRecord::Base
  belongs_to :language
  belongs_to :user
  
  acts_as_taggable_on :topics, :questions
  #attr_accessible :title, :url, :user_id, :description, :language_id
  
  validate :unique_url
  
  def unique_url
    errors.add_to_base 'URL is already bookmarked' if Bookmark.find_by_url(self.url)
  end
  
  def self.per_page
    40
  end
end
