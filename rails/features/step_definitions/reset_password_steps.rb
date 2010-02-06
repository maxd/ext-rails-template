Then /^I should be with user.perishable_token on the reset password page$/ do
  user = User.first(:conditions => { :email => "admin@example.com" })

  Then "I should be on the reset password page with Id \"#{user.perishable_token}\""
end

Given /I am request reset password for "([^\"]*)" email/ do |email|
  steps %Q{
    Given I am a not logined to application
    When I go to the request reset password page
    And fill in "Email" with "#{email}"
    And press "Send request"
    Then I should see flash with "Instructions to reset your password have been emailed to you."
  }
end

Given /open reset password page from "([^\"]*)" email/ do |email|
  steps %Q{
    Given "#{email}" should receive an email
    When I open the email
    Then I should see "Reset Password!" in the email body
    When I follow "Reset Password!" in the email
    Then I should be with user.perishable_token on the reset password page
  }
end