class Bookmark < ActiveRecord::Base
  belongs_to :language
  belongs_to :user
  has_many :comments
  before_save :generate_permalink
  after_save :generate_thumb
  
  acts_as_taggable
  
  has_attached_file :thumb, :styles => {:small => "150x108", :medium => "280x202", :large => "430x310"},
                    :url  => "/assets/thumbs/:style_:basename.:extension",
                    :path => ":rails_root/public/assets/thumbs/:style_:basename.:extension",
                    :default_style => "medium",
                    :default_url => "/images/missing.png"
                    
  validates_uniqueness_of :url
  
  def self.per_page
    8
  end
      
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
  
    def generate_thumb
      @bookmark = Bookmark.find(:last, :select => "id")
      
      Delayed::Job.enqueue(DelayedThumbnail.new(@bookmark.id), 0, 10.minutes.from_now)
    end
end
