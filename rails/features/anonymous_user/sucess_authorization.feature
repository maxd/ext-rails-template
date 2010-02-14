Feature: Anonymous user should have access to dashboard, register, reset password and login pages only
  In order to restrict anonymous users functionality in application
  A anonymous  user
  Should have access to dashboard, register, reset password and login pages only

  Scenario: Anonymous user should have access to dashboard page
    Given I am anonymous user
    When I go to the dashboard page
    Then I should be on the dashboard page

  Scenario: Anonymous user should have access to login page
    Given I am anonymous user
    When I go to the login page
    Then I should be on the login page

  @registration_enabled
  Scenario: Anonymous user should have access to register page if application developer allow access to it page
    Given I am anonymous user
    When I go to the registration page
    Then I should be on the registration page

  @reset_password_enabled
  Scenario: Anonymous user should have access to request reset password page if application developer allow access to it page
    Given I am anonymous user
    When I go to the request reset password page
    Then I should be on the request reset password page
