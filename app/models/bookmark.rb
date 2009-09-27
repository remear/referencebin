class Bookmark < ActiveRecord::Base
  belongs_to :language
  belongs_to :user
  has_many :comments
  before_save :generate_permalink
  
  acts_as_taggable
  
  private
    def generate_permalink
        title_based_permalink = self.title.gsub(" ", "-")
        title_based_permalink = title_based_permalink.match('([A-Za-z0-9\-])+').to_s
        self.permalink = title_based_permalink.downcase
    end
end
