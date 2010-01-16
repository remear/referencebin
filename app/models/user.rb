class User < ActiveRecord::Base
  has_many :bookmarks
  has_many :bookmark_imports
  has_many :comments, :as => :commentable
  has_many :articles
  has_many :jots
  
  attr_accessible :login, :email, :firstname, :lastname, :nickname, :password, :password_confirmation
  login_field_type => :email
  #for gravatar
  is_gravtastic! :secure => true,
                 :size => 120,
                 :size => 120,
                 :default => "wavatar"
  
  acts_as_authentic do |c|
    #c.transition_from_crypto_providers = Authlogic::CryptoProviders::Sha512
    c.crypto_provider = Authlogic::CryptoProviders::BCrypt
  end
  
  acts_as_tagger
  
  def deliver_verification_instructions!
    self.active = false
    reset_perishable_token!
    save
    Notifier.deliver_verification_instructions!(self)
  end

  def verify!
    self.active = true
    save
  end
end

# == Schema Information
#
# Table name: users
#
#  id                  :integer(4)      not null, primary key
#  login               :string(255)     not null
#  email               :string(255)     not null
#  firstname           :string(255)     not null
#  lastname            :string(255)     not null
#  nickname            :string(255)     not null
#  admin               :boolean(1)      default(FALSE)
#  crypted_password    :string(255)     not null
#  password_salt       :string(255)     not null
#  persistence_token   :string(255)     not null
#  single_access_token :string(255)     not null
#  perishable_token    :string(255)     not null
#  login_count         :integer(4)      default(0), not null
#  failed_login_count  :integer(4)      default(0), not null
#  last_request_at     :datetime
#  current_login_at    :datetime
#  last_login_at       :datetime
#  current_login_ip    :string(255)
#  last_login_ip       :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#  landing_page        :integer(4)      default(0)
#  active              :boolean(1)
#

