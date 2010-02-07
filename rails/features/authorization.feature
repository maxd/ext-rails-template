Feature: Anonymous user shouldn't have access for some application resources
  In order to restrict access for some application resources
  A anonymous user
  Shouldn't have access for some application resources

  Scenario: Anonymous user should have access to dashboard page
    Given I am a not logined to application
    When I go to the dashboard page
    Then I should be on the dashboard page

  Scenario: Anonymous user should have access to login page
    Given I am a not logined to application
    When I go to the login page
    Then I should be on the login page

  @registration_enabled  
  Scenario: Anonymous user should have access to register page
    Given I am a not logined to application
    When I go to the registration page
    Then I should be on the registration page

  @registration_disabled @allow-rescue
  Scenario: Anonymous user should not have access to register page
    Given I am a not logined to application
    When I go to the registration page
    Then I should be on the login page

  @reset_password_enabled
  Scenario: Anonymous user should have access to request reset password page
    Given I am a not logined to application
    When I go to the request reset password page
    Then I should be on the request reset password page

  @reset_password_disabled @allow-rescue
  Scenario: Anonymous user should have access to request reset password page
    Given I am a not logined to application
    When I go to the request reset password page
    Then I should be on the login page

  @allow-rescue
  Scenario: Anonymous user shouldn't have access to logout page
    Given I am a not logined to application
    When I go to the logout page
    Then I should be on the login page

  @allow-rescue
  Scenario: Anonymous user shouldn't have access to profile page
    Given I am a not logined to application
    When I go to the profile page
    Then I should be on the login page

  @allow-rescue
  Scenario: Anonymous user shouldn't have access to edit profile page
    Given I am a not logined to application
    When I go to the edit profile page
    Then I should be on the login page

  @allow-rescue
  Scenario: Authenticated user shouldn't have access to login page
    Given I am logined to application
    When I go to the login page
    Then I should be on the dashboard page
    And should see flash with "Access denied."

  @allow-rescue
  Scenario: Authenticated user shouldn't have access to register page
    Given I am logined to application
    When I go to the registration page
    Then I should be on the dashboard page
    And should see flash with "Access denied."

  @allow-rescue
  Scenario: Authenticated user shouldn't have access to request reset password page
    Given I am logined to application
    When I go to the request reset password page
    Then I should be on the dashboard page
    And should see flash with "Access denied."
