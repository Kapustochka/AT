Feature: User's signing out
  In order to save their data
  Users should be able to sign out

  Scenario: User logs out after logging in
    Given user is on login page
    When user logs in with correct creds
    And user clicks logout button
    Then home page should be displayed
    And home page should have content 'Signed out successfully.'
