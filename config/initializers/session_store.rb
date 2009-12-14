# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_atc_session',
  :secret      => 'dd946238dda90bc318b9ba73c213d06578b6e6aa20b49e640879f232a1fa87c628b4871899826c7dd35c40c8bdf03943203cc560bda2de72d8603b6433558280'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
