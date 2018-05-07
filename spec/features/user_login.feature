Feature: User's signing in
  In order to be authorised
  Users should be able to sign in

  Background:
    Given there is a home page
    And there is a login page

  Scenario: User opens login page via menu
    Given user is on home page
    When user clicks login button
    Then login page should be displayed

  Scenario: User logs in with correct creds directly
    Given user is on login page
    # When user fills in email field with 'admin@strongqa.com'
    # And user fills in password field with '1234567890'
    # And user clicks login button
    When user logs in with correct creds
    Then home page should be displayed
    And home page should have content 'Signed in successfully.'

  Scenario: User logs in with blank email
    Given user is on login page
    # When user fills in email field with ''
    # And user fills in password field with '1234567890'
    # And user clicks login button
    When user logs in with blank password
    Then login page should be displayed
    And home page should have content 'Invalid email or password.'

  Scenario: User logs in with blank password
    Given user is on login page
    # When user fills in email field with 'admin@strongqa.com'
    # And user fills in password field with ''
    # And user clicks login button
    When user logs in with blank password
    Then login page should be displayed
    And home page should have content 'Invalid email or password.'

  Scenario: User logs in with blank email and password
    Given user is on login page
    # When user fills in email field with ''
    # And user fills in password field with ''
    # And user clicks login button
    When user logs in with blank email and password
    Then login page should be displayed
    And home page should have content 'Invalid email or password.'

  Scenario: User logs in with incorrect email
    Given user is on login page
    # When user fills in email field with 'blablaadmin@strongqa.com'
    # And user fills in password field with '1234567890'
    # And user clicks login button
    When user logs in with incorrect email
    Then login page should be displayed
    And home page should have content 'Invalid email or password.'

  Scenario: User logs in with incorrect password
    Given user is on login page
    # When user fills in email field with 'admin@strongqa.com'
    # And user fills in password field with 'blabla1234567890'
    # And user clicks login button
    When user logs in with incorrect password
    Then login page should be displayed
    And home page should have content 'Invalid email or password.'

  Scenario: User logs in with incorrect email and password
    Given user is on login page
    # When user fills in email field with 'blablaadmin@strongqa.com'
    # And user fills in password field with '1234567890'
    # And user clicks login button
    When user logs in with incorrect password and email
    Then login page should be displayed
    And home page should have content 'Invalid email or password.'
