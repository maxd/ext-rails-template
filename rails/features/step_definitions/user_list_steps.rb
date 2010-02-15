Then /I should see (\d+) user accounts in table/ do |number|
  response.should have_selector("table.users td.user-login", :count => number)
end

Then /I should see "([^\"]*)" user account in table/ do |login|
  response.should have_selector("table.users td.user-login") do |matched|
    matched.any? {|item| item.text == login }
  end
end

Then /click edit account link for user with login "([^\"]*)"/ do |login|
  user = User.find_by_login(login)
  within "#user-#{user.id}" do |scope|
    scope.click_link "Edit"
  end
end

When /^user with login "([^\"]*)" has email "([^\"]*)"$/ do |login, email|
  user = User.find_by_login(login)
  user.email.should eql(email)  
end

When /^user with login "([^\"]*)" has password "([^\"]*)"$/ do |login, password|
  user = User.find_by_login(login)
  user.valid_password?(password).should be_true  
end

When /^user with login "([^\"]*)" has first name "([^\"]*)" and last name "([^\"]*)"$/ do |login, first_name, last_name|
  user = User.find_by_login(login)
  user.first_name.should eql(first_name)
  user.last_name.should eql(last_name)  
end

Then /^click delete account link for user with login "([^\"]*)"$/ do |login|
  user = User.find_by_login(login)
  within "#user-#{user.id}" do |scope|
    scope.click_link "Delete"
  end
end

Then /^I shouldn't see delete link for user with login "([^\"]*)"$/ do |login|
  user = User.find_by_login(login)
  within "#user-#{user.id}" do |scope|
    scope.dom.should have_selector("td > img[@alt='Delete']")
  end

end

