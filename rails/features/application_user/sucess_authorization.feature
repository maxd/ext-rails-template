Feature: Application user should have access to dashboard, profile and profile editor pages
  In order to partially restrict application users functionality in application
  A application user
  Should have access to dashboard, profile and profile editor page

  Scenario: Application user should have access to dashboard page
    Given I am application user
    When I go to the dashboard page
    Then I should be on the dashboard page

  Scenario: Application user should have access to profile page
    Given I am application user
    When I go to the profile page
    Then I should be on the profile page

  Scenario: Application user should have access to edit profile page
    Given I am application user
    When I go to the edit profile page
    Then I should be on the edit profile page
