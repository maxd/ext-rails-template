module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name
    
    when /the home\s?page/
      dashboard_path
    when /the dashboard page/
      dashboard_path
    when /the login page/
      login_path
    when /the logout page/
      logout_path
    when /the registration page/
      register_path
    when /the request reset password page/
      request_reset_password_path
    when /the reset password page with Id "([^\"]*)"/
      reset_password_path($1)
    when /the profile page/
      profile_path
    when /the edit profile page/
      edit_profile_path
    when /the admin dashboard page/
      admin_dashboard_path
    when /the user list in admin panel page/
      admin_users_path


    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(NavigationHelpers)
