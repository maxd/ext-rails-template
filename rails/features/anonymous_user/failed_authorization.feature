Feature: Anonymous user shouldn't have access to private application resources
  In order to restrict access to private application resources
  A anonymous user
  Shouldn't have access to several pages

  @registration_disabled @allow-rescue
  Scenario: Anonymous user shouldn't have access to register page if application developer restrict access to it page
    Given I am anonymous user
    When I go to the registration page
    Then I should be on the login page
    And should see flash with "Access denied."

  @reset_password_disabled @allow-rescue
  Scenario: Anonymous user shouldn't have access to request reset password page if application developer restrict access to it page
    Given I am anonymous user
    When I go to the request reset password page
    Then I should be on the login page
    And should see flash with "Access denied."

  @allow-rescue
  Scenario: Anonymous user shouldn't have access to logout page
    Given I am anonymous user
    When I go to the logout page
    Then I should be on the login page
    And should see flash with "Access denied."

  @allow-rescue
  Scenario: Anonymous user shouldn't have access to profile page
    Given I am anonymous user
    When I go to the profile page
    Then I should be on the login page
    And should see flash with "Access denied."

  @allow-rescue
  Scenario: Anonymous user shouldn't have access to edit profile page
    Given I am anonymous user
    When I go to the edit profile page
    Then I should be on the login page
    And should see flash with "Access denied."

  @allow-rescue
  Scenario: Anonymous user shouldn't have access to admin dashboard page
    Given I am anonymous user
    When I go to the admin dashboard page
    Then I should be on the login page
    And should see flash with "Access denied."

  @allow-rescue
  Scenario: Anonymous user shouldn't have access to user list page in admin panel
    Given I am anonymous user
    When I go to the user list in admin panel page
    Then I should be on the login page
    And should see flash with "Access denied."
    