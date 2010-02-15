Before do

  # Create user account without administration privileges
  User.create! :login => "user",
               :email => "user@example.com",
               :first_name => "User",
               :last_name => "User", 
               :password => "user", :password_confirmation => "user"

end