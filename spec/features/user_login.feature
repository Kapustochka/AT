
Feature: Attacking a monster
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
