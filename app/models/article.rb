class Article < ActiveRecord::Base
  belongs_to :language
  belongs_to :user
  has_many :comments, :as => :commentable
  after_create :generate_permalink
  acts_as_taggable_on :topics, :questions
  

  
  
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
end

# == Schema Information
#
# Table name: articles
#
#  id           :integer(4)      not null, primary key
#  content      :text
#  content_html :text
#  user_id      :integer(4)
#  published    :boolean(1)
#  commentable  :boolean(1)
#  created_at   :datetime
#  updated_at   :datetime
#  title        :string(255)
#  permalink    :string(255)
#  language_id  :integer(4)
#

