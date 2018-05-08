Feature: User's signing in
  In order to be authorised
  Users should be able to sign in

  Scenario: User opens login page via menu
    Given user is on home page
    When user clicks login button on home page
    Then login page should be displayed

  Scenario: User logs in with correct creds directly
    Given user is on login page
    When user logs in with correct creds
    Then home page should be displayed
    And user should see alert about successfull sign in

  Scenario: User logs in with blank email
    Given user is on login page
    When user logs in with blank password
    Then login page should be displayed
    And user should see alert about wrong login or password

  Scenario: User logs in with blank password
    Given user is on login page
    When user logs in with blank password
    Then login page should be displayed
    And user should see alert about wrong login or password

  Scenario: User logs in with blank email and password
    Given user is on login page
    When user logs in with blank email and password
    Then login page should be displayed
    And user should see alert about wrong login or password

  Scenario: User logs in with incorrect email
    Given user is on login page
    When user logs in with incorrect email
    Then login page should be displayed
    And user should see alert about wrong login or password

  Scenario: User logs in with incorrect password
    Given user is on login page
    When user logs in with incorrect password
    Then login page should be displayed
    And user should see alert about wrong login or password

  Scenario: User logs in with incorrect email and password
    Given user is on login page
    When user logs in with incorrect email and password
    Then login page should be displayed
    And user should see alert about wrong login or password
