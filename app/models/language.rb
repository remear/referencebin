class Language < ActiveRecord::Base
  has_many :bookmarks
  has_many :bookmark_imports
  has_many :comments
  has_many :questions
  has_many :jots
  
  before_save :generate_permalink

  private
    def generate_permalink
        name_based_permalink = self.name.gsub(" ", "-")
        name_based_permalink = name_based_permalink.match('([A-Za-z0-9\-])+').to_s
        self.permalink = name_based_permalink.downcase
    end
end
