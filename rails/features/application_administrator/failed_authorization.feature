Feature: Application administrator hasn't access to several application pages
  In order to restrict access to several application pages for authenticated users
  A application administrator
  Haven't access to these pages

  @allow-rescue
  Scenario: Application administrator shouldn't have access to login page (because he login already)
    Given I am application administrator
    When I go to the login page
    Then I should be on the dashboard page
    And should see flash with "Access denied."

  @allow-rescue
  Scenario: Application administrator shouldn't have access to register page (because he registered already)
    Given I am application administrator
    When I go to the registration page
    Then I should be on the dashboard page
    And should see flash with "Access denied."

  @allow-rescue
  Scenario: Application administrator shouldn't have access to request reset password page (because he known password already)
    Given I am application administrator
    When I go to the request reset password page
    Then I should be on the dashboard page
    And should see flash with "Access denied."
