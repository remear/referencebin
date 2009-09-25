class Language < ActiveRecord::Base
  has_many :bookmarks
  before_save :generate_permalink
  has_many :comments
  
  private
    def generate_permalink
        name_based_permalink = self.name.gsub(" ", "-")
        name_based_permalink = name_based_permalink.match('([A-Za-z0-9\-])+').to_s
        self.permalink = name_based_permalink.downcase
    end
end
