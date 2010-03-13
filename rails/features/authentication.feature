Feature: Authentication to application
  In order to login to application
  As registered user
  Should have ability to login in application 

  Scenario: Anonymous user should see login link on dashboard page
    Given I am anonymous user
    When I go to the dashboard page
    Then I should see "/login" link

  Scenario: Success login to application
    Given I am anonymous user
    When I go to the login page
    And I fill in the following:
      | Login                 | user            |
      | Password              | user            |
    And press "Login"
    Then I should authenticated in application
    And should see "/profile" link
    And "/logout" link

  Scenario: Fail login to application with invalid login
    Given I am anonymous user
    When I go to the login page
    And I fill in the following:
      | Login                 | adminko         |
      | Password              | user            |
    And press "Login"
    Then I should see form validation for "Login" field
    And shouldn't authenticated in application
    And should see "/login" link

  Scenario: Fail login to application with invalid password
    Given I am anonymous user
    When I go to the login page
    And I fill in the following:
      | Login                 | user            |
      | Password              | adminko         |
    And press "Login"
    Then I should see form validation for "Password" field
    And shouldn't authenticated in application
    And should see "/login" link
