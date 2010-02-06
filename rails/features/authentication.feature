Feature: Authentication to application
  In order to work with application
  As registered user
  I want to login in application

  Scenario: Not logined user should see login link on dashboard page
    Given I am a not logined to application
    When I go to the dashboard page
    Then I should see "/login" link

  Scenario: Success login to application
    Given I am a not logined to application
    When I go to the login page
    And I fill in the following:
      | Login                 | admin            |
      | Password              | admin            |
    And press "Login"
    Then I should see flash with "Login successful!"
    And should be logined to application
    And should see "/profile" link
    And "/logout" link

  Scenario: Fail login to application with invalid login
    Given I am a not logined to application
    When I go to the login page
    And I fill in the following:
      | Login                 | adminko          |
      | Password              | admin            |
    And press "Login"
    Then I should see form validation for "Login" field
    And should not be logined to application
    And should see "/login" link

  Scenario: Fail login to application with invalid password
    Given I am a not logined to application
    When I go to the login page
    And I fill in the following:
      | Login                 | admin            |
      | Password              | adminko          |
    And press "Login"
    Then I should see form validation for "Password" field
    And should not be logined to application
    And should see "/login" link
