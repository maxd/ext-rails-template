Given /^I am anonymous user$/ do
  visit dashboard_path
  controller.send(:current_user).should be_nil
end

Given /^I am application user$/ do
  steps %Q{
    Given I am anonymous user
    When I go to the login page
    And I fill in the following:
      | Login                 | user            |
      | Password              | user            |
    And press "Login"
    Then I should authenticated in application
  }
end

Given /^I am application administrator$/ do
  steps %Q{
    Given I am anonymous user
    When I go to the login page
    And I fill in the following:
      | Login                 | admin           |
      | Password              | admin           |
    And press "Login"
    Then I should authenticated in application
  }
end

Then /^(?:|I )should authenticated in application$/ do
  controller.send(:current_user).should_not be_nil
end

Then /^(?:|I )shouldn't authenticated in application$/ do
  controller.send(:current_user).should be_nil
end

