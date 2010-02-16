Feature: The application administrator can manage registered user accounts
  In order to manage registered user accounts
  A application administrator
  Should have ability to see/create/edit/delete registered user accounts

  Scenario: The application administrator should see registered user accounts
    Given I am application administrator
    When I go to the user list in admin panel page
    Then I should see 2 user accounts in table

  Scenario: The application administrator can create new user account
    Given I am application administrator
    When I go to the new user in admin panel page
    And I fill in the following:
      | Login                 | maksimka             |
      | E-Mail                | maksimka@example.com |
      | First name            | Maksimka             |
      | Last name             | Dobriakov            |
      | Password              | password             |
      | Password Confirmation | password             |
    And press "Create Account"
    Then I am on the user list in admin panel page
    And I should see 3 user accounts in table
    And I should see "maksimka" user account in table

  Scenario: The application administrator can change email for user account
    Given I am application administrator
    When I go to the user list in admin panel page
    Then click edit account link for user with login "user"
    When I fill in the following:
      | E-Mail                | new_email@example.com |
    And press "Update Account"
    Then I am on the user list in admin panel page
    And I should see 2 user accounts in table
    And user with login "user" has email "new_email@example.com"

  Scenario: The application administrator can change first and last name for user account
    Given I am application administrator
    When I go to the user list in admin panel page
    Then click edit account link for user with login "user"
    When I fill in the following:
      | First name            | Vini                  |
      | Last name             | Pooh                  |
    And press "Update Account"
    Then I am on the user list in admin panel page
    And I should see 2 user accounts in table
    And user with login "user" has first name "Vini" and last name "Pooh"

  Scenario: The application administrator can change password for user account
    Given I am application administrator
    When I go to the user list in admin panel page
    Then click edit account link for user with login "user"
    When I fill in the following:
      | Password                 | 12345 |
      | Password Confirmation    | 12345 |
    And press "Update Account"
    Then I am on the user list in admin panel page
    And I should see 2 user accounts in table
    And user with login "user" has password "12345"

  Scenario: The application administrator can delete user account
    Given I am application administrator
    When I go to the user list in admin panel page
    Then click delete account link for user with login "user"
    Then I am on the user list in admin panel page
    And I should see 1 user accounts in table

  Scenario: The application administrator can't delete administrator account with login "admin"
    Given I am application administrator
    When I go to the user list in admin panel page
    Then I shouldn't see delete link for user with login "admin"