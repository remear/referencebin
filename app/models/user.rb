class User < ActiveRecord::Base
  has_many :bookmarks
  has_many :bookmark_imports
  has_many :comments
  has_many :jots
  
  attr_accessible :login, :email, :firstname, :lastname, :nickname, :password, :password_confirmation
  
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
end
