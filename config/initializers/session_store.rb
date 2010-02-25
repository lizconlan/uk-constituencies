# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_uk-constituencies_session',
  :secret      => '85e20fd58ddbf530b4bf67583aacae1e8b77cfac37b700ab11371a824b81d44b0fa01e076096abe6e898076b7d4feb23d75db707570222a9834f06f728cdbc82'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
