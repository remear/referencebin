class Bookmark < ActiveRecord::Base
  belongs_to :language
  belongs_to :user
  has_many :comments
  after_create :generate_permalink
  after_create :generate_thumb
  
  acts_as_taggable_on :topics, :questions
  
  has_attached_file :thumb, :styles => {:small => "150x108", :medium => "280x202", :large => "430x310"},
                    :url  => "/assets/thumbs/:style_:basename.:extension",
                    :path => ":rails_root/public/assets/thumbs/:style_:basename.:extension",
                    :default_style => "medium",
                    :default_url => "/images/missing.png"
                    
  validates_uniqueness_of :url
  
  define_index do
    # fields
    indexes title, :sortable => true
    indexes description
    indexes comments.body
    indexes taggings.tag(:name), :as => :topic
    indexes language.name, :as => :language, :sortable => true
    indexes [user.firstname, user.lastname], :as => :author, :sortable => true

    # attributes
    has user_id, language_id, created_at, updated_at
  end
    
  def self.per_page
    5
  end
  
  def to_param
    "#{id}-#{title.gsub(/[^a-z0-9]+/i, '-')}"
  end
    
  private
    def generate_permalink
      update_attributes(:permalink => "#{self.id}-#{self.title.parameterize}") 
    end
  
    def generate_thumb
      #TODO: move developer_key to an environment variable or place in initializer
      PageGlimpse.developer_key = '85fd3e91a4874a31c048797113c9bf8e'
      PageGlimpse.queue(self.url)
    end
end
