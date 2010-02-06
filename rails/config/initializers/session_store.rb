# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_rails_template_session',
  :secret      => 'b9b9f7edc221e9294d2a1919448cc36bfa140e833317f38f78db3f979aaaae7aa7175e27e34cedfbea90fbe6760814a73c32067070282d76943996a11214ced4'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
