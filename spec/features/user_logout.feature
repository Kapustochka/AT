Feature: User's signing out
  In order to save their data
  Users should be able to sign out

  Background:
    Given there is a home page
    And there is a login page

  Scenario: User logs out after logging in
    Given user is on login page
    # When user fills in email field with 'admin@strongqa.com'
    # And user fills in password field with '1234567890'
    # And user clicks login button
    When user logs in with correct creds
    And user clicks logout button
    Then home page should be displayed
    And home page should have content 'Signed out successfully.'
