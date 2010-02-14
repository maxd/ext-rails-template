Before do

  # Create user account without administration privileges
  User.create!(:login => "user", :email => "user@example.com", :password => "user", :password_confirmation => "user")

end