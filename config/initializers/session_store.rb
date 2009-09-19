# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_org_session',
  :secret      => '60a58ac3e407ecc9ab6f2c4453ab6dd2182fd2090f383ee9babb625ee7b6927537bf06a76d21bc79b8fbc5d1d5481377da6f207b4535269ef34814b78da39f35'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
