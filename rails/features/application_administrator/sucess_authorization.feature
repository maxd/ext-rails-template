Feature: Application administrator should have access to all pages
  In order to grant full access to private application functionality
  A application administrator
  Should have access to all pages

  Scenario: Application administrator should have access to dashboard page
    Given I am application administrator
    When I go to the dashboard page
    Then I should be on the dashboard page

  Scenario: Application administrator should have access to profile page
    Given I am application administrator
    When I go to the profile page
    Then I should be on the profile page

  Scenario: Application administrator should have access to edit profile page
    Given I am application administrator
    When I go to the edit profile page
    Then I should be on the edit profile page

  Scenario: Application administrator should have access to admin dashboard page
    Given I am application administrator
    When I go to the admin dashboard page
    Then I should be on the admin dashboard page

  Scenario: Application administrator should have access to user list in admin panel
    Given I am application administrator
    When I go to the user list in admin panel page
    Then I should be on the user list in admin panel page
