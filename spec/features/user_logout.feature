Feature: Signing out
  As a user
  i want to log out of the page
  So that i can defend my data

  Background:
    Given there is a home page
    And there is a login page

  Scenario: logging out after login
    Given I am on login page
    When I fill in email field with 'admin@strongqa.com'
    And I fill in password field with '1234567890'
    And I click login button
    And I click logout button
    Then home page is displayed
    And home page has content 'Signed out successfully.'
