require 'digest/sha1'

class User < ActiveRecord::Base
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken
  include Authorization::AasmRoles

  has_many :bookmarks
  has_many :bookmark_imports
  has_many :comments
  
  validates_presence_of     :login
  validates_length_of       :login,     :within => 3..40
  validates_uniqueness_of   :login
  validates_format_of       :login,     :with => Authentication.login_regex, :message => Authentication.bad_login_message
  validates_presence_of     :email
  validates_length_of       :email,     :within => 6..100 #r@a.wk
  validates_uniqueness_of   :email
  validates_format_of       :email,     :with => Authentication.email_regex, :message => Authentication.bad_email_message
  validates_presence_of     :nickname
  validates_uniqueness_of   :nickname
  validates_presence_of     :firstname, :with => Authentication.name_regex,  :message => Authentication.bad_name_message
  validates_length_of       :firstname, :maximum => 100
  validates_presence_of     :lastname,  :with => Authentication.name_regex,  :message => Authentication.bad_name_message
  validates_length_of       :lastname,  :maximum => 100
  
  #for gravatar
  is_gravtastic! :secure => true,
                 :size => 120,
                 :size => 120,
                 :default => "wavatar"
  
  acts_as_tagger
  
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :firstname, :lastname, :nickname, :password, :password_confirmation

  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  def self.authenticate(login, password)
    return nil if login.blank? || password.blank?
    u = find_in_state :first, :active, :conditions => {:login => login.downcase} # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  def login=(value)
    write_attribute :login, (value ? value.downcase : nil)
  end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end

  protected
    #create code for activating the user account
    def make_activation_code
        self.deleted_at = nil
        self.activation_code = self.class.make_token
    end
end
