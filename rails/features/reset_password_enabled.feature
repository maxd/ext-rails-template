@reset_password_enabled
Feature: Reset password feature enabled
  In order to restore forgotten password
  A registered user
  Should have ability to restore password

  Scenario: User select incorrect e-mail
    Given I am anonymous user
    When I go to the request reset password page
    And fill in "E-Mail" with "unknown@example.com"
    And press "Send request"
    Then I should see flash with "No user was found with that email address"

  Scenario: User select correct email and reset password
    Given I am request reset password for "admin@example.com" email
    And open reset password page from "admin@example.com" email
    When I fill in "Password" with "newpass"
    And fill in "Password confirmation" with "newpass"
    And press "Reset Password"
    Then I should see flash with "Password successfully updated"
    And should authenticated in application
    And I should be able to log in with login "admin" and password "newpass"

  Scenario: User select correct email and enter incorrect reset password
    Given I am request reset password for "admin@example.com" email
    And open reset password page from "admin@example.com" email
    When I fill in "Password" with "newpass"
    And fill in "Password confirmation" with "newpass2"
    And press "Reset Password"
    Then I should see form validation for "Password"
    Then shouldn't authenticated in application
    And I should be able to log in with login "admin" and password "admin"

  Scenario: User open reset password with nonexistent perishable token
    When I go to the reset password page with Id "unknown"
    Then I should see flash with "we could not locate your account"
    And shouldn't authenticated in application

