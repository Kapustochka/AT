Feature: Signing in
  As a user
  i want to login on page
  So that i can be authorised

  Background:
    Given there is a home page
    And there is a login page

  Scenario: open login page via menu
    Given I am on home page
    When I click login button
    Then login page is displayed

  Scenario: logging in with correct creds directly
    Given I am on login page
    When I fill in email field with 'admin@strongqa.com'
    And I fill in password field with '1234567890'
    And I click login button
    Then home page is displayed
    And home page has content 'Signed in successfully.'

  Scenario: logging in with blank email
    Given I am on login page
    When I fill in email field with ''
    And I fill in password field with '1234567890'
    And I click login button
    Then login page is displayed
    And home page has content 'Invalid email or password.'

  Scenario: logging in with blank password
    Given I am on login page
    When I fill in email field with 'admin@strongqa.com'
    And I fill in password field with ''
    And I click login button
    Then login page is displayed
    And home page has content 'Invalid email or password.'

  Scenario: logging in with blank email and password
    Given I am on login page
    When I fill in email field with ''
    And I fill in password field with ''
    And I click login button
    Then login page is displayed
    And home page has content 'Invalid email or password.'

  Scenario: logging in with incorrect email
    Given I am on login page
    When I fill in email field with 'blablaadmin@strongqa.com'
    And I fill in password field with '1234567890'
    And I click login button
    Then login page is displayed
    And home page has content 'Invalid email or password.'

  Scenario: logging in with incorrect password
    Given I am on login page
    When I fill in email field with 'admin@strongqa.com'
    And I fill in password field with 'blabla1234567890'
    And I click login button
    Then login page is displayed
    And home page has content 'Invalid email or password.'

  Scenario: logging in with incorrect email and password
    Given I am on login page
    When I fill in email field with 'blablaadmin@strongqa.com'
    And I fill in password field with '1234567890'
    And I click login button
    Then login page is displayed
    And home page has content 'Invalid email or password.'
