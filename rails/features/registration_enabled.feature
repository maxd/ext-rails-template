@registration_enabled
Feature: Registration in application feature enabled
  In order to work with advanced features of application
  As anonymous user
  I want to register in application

  
  Scenario: Anonymous user should see register link on dashboard page
    Given I am anonymous user
    When I go to the dashboard page
    Then I should see "/register" link


  Scenario: Success registration in application
    Given I am anonymous user
    When I go to the registration page
    And I fill in the following:
      | Login                 | maksimka             |
      | Password              | password             |
      | Password Confirmation | password             |
      | Email                 | maksimka@example.com |
    And press "Register"
    Then I should be registered in application


  Scenario: Fail registration in application with empty fields
    Given I am anonymous user
    When I go to the registration page
    And I fill in the following:
      | Login                 |                  |
      | Password              |                  |
      | Password Confirmation |                  |
      | Email                 |                  |
    And press "Register"
    Then I should see form validation for "Login" field
    And should see form validation for "Password" field
    And should see form validation for "Password confirmation" field
    And should see form validation for "Email" field
    And should not be registered in application


  Scenario: Fail registration in application with empty login
    Given I am anonymous user
    When I go to the registration page
    And I fill in the following:
      | Login                 |                      |
      | Password              | password             |
      | Password Confirmation | password             |
      | Email                 | maksimka@example.com |
    And press "Register"
    Then I should see form validation for "Login" field
    And should not be registered in application


  Scenario: Fail registration in application with empty password
    Given I am anonymous user
    When I go to the registration page
    And I fill in the following:
      | Login                 | maksimka             |
      | Password              |                      |
      | Password Confirmation | password             |
      | Email                 | maksimka@example.com |
    And press "Register"
    Then I should see form validation for "Password" field
    And should not be registered in application


  Scenario: Fail registration in application with different password and confirmation password
    Given I am anonymous user
    When I go to the registration page
    And I fill in the following:
      | Login                 | maksimka             |
      | Password              | password             |
      | Password Confirmation | password2            |
      | Email                 | maksimka@example.com |
    And press "Register"
    Then I should see form validation for "Password" field
    And should not be registered in application


  Scenario: Fail registration in application with empty e-mail
    Given I am anonymous user
    When I go to the registration page
    And I fill in the following:
      | Login                 | maksimka         |
      | Password              | password         |
      | Password Confirmation | password         |
      | Email                 |                  |
    And press "Register"
    Then I should see form validation for "Email" field 
    And should not be registered in application


  Scenario: Fail registration in application with login which already registered
    Given I am anonymous user
    When I go to the registration page
    And I fill in the following:
      | Login                 | admin             |
      | Password              | pass              |
      | Password Confirmation | pass              |
      | Email                 | admin@example.com |
    And press "Register"
    Then I should see form validation for "Login" field
    And should not be registered in application


  Scenario: Anonymous user can press Cancel link and return to dashboard page
    Given I am anonymous user
    When I go to the registration page
    And follow "Cancel"
    Then I should be on the dashboard page

    