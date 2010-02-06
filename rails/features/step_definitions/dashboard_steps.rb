Given /^I am anonymous user$/ do
  @current_user = nil
end

Then /^I should see dashboard page$/ do
  response.should have_selector("div.app-container")
end

Given /^I am sing up user$/ do
  @current_user = User.first
end