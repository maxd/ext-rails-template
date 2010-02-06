Feature: Show dashboard page
  In order to show home/root page
  A any user
  Should be able to see dashboard page

  Scenario: Show dashboard page for anonymous user
    Given I am anonymous user
    When I go to the dashboard page
    Then I should see dashboard page

  Scenario: Show dashboard page for sign up user
    Given I am sing up user
    When I go to the dashboard page
    Then I should see dashboard page