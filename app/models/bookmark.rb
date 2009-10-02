class Bookmark < ActiveRecord::Base
  belongs_to :language
  belongs_to :user
  has_many :comments
  before_save :generate_permalink
  
  acts_as_taggable
  
  validates_uniqueness_of :url
  
  private
    def generate_permalink
        title_based_permalink = self.title.gsub(" ", "-")
        title_based_permalink = title_based_permalink.match('([A-Za-z0-9\-])+').to_s
        @last_record = Bookmark.find(:last, :select => "id")
        if @last_record.nil?
          id = 1
        else
          id = @last_record.id + 1
        end
        self.permalink = "#{id}-#{title_based_permalink.downcase}"
    end
end
