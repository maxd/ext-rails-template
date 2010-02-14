Feature: Application user (not application Administrator) should has partial access to private application resource
  In order to partially restrict access to private application resources
  A application user (not application Administrator)
  Should have access to several application pages

  @allow-rescue
  Scenario: Application user shouldn't have access to login page (because he login already)
    Given I am application user
    When I go to the login page
    Then I should be on the dashboard page
    And should see flash with "Access denied."

  @allow-rescue
  Scenario: Application user shouldn't have access to register page (because he registered already)
    Given I am application user
    When I go to the registration page
    Then I should be on the dashboard page
    And should see flash with "Access denied."

  @allow-rescue
  Scenario: Application user shouldn't have access to request reset password page (because he known password already)
    Given I am application user
    When I go to the request reset password page
    Then I should be on the dashboard page
    And should see flash with "Access denied."

  @allow-rescue
  Scenario: Application user shouldn't have access to admin dashboard page
    Given I am application user
    When I go to the admin dashboard page
    Then I should be on the dashboard page
    And should see flash with "Access denied."

  @allow-rescue
  Scenario: Application user shouldn't have access to user list page in admin panel
    Given I am application user
    When I go to the user list in admin panel page
    Then I should be on the dashboard page
    And should see flash with "Access denied."
