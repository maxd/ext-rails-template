Given /^I am a not logined to application$/ do
  visit dashboard_path
  controller.send(:current_user).should be_nil
end

Given /^I am logined to application$/ do
  steps %Q{
    Given I am a not logined to application
    When I go to the login page
    And I fill in the following:
      | Login                 | admin            |
      | Password              | admin            |
    And press "Login"
    Then I should see flash with "Login successful!"
  }
end

Then /^(?:|I )should be logined to application$/ do
  controller.send(:current_user).should_not be_nil
end

Then /^(?:|I )should not be logined to application$/ do
  controller.send(:current_user).should be_nil
end

