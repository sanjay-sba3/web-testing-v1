@TS-49
Feature: Login Page Functionality
  As a user
  I want to be able to log in to the application
  So that I can access its features

  @TC-TC1
  Scenario: Verify Login Page UI Elements
    Given I open the "http://localhost:8080/login.html" page
    Then I should see the "Email" field
    And I should see the "Password" field
    And I should see the "Sign in" button

  @dryrun @TC-TC2
  Scenario: Successful Login with Valid Credentials
    Given I open the "http://localhost:8080/login.html" page
    When I login with credentials from "validCredentials"
    Then the URL should contain "/dashboard"
    And I should see the text "Welcome"

  @TC-TC3
  Scenario: Login attempt with empty email field
    Given I open the "http://localhost:8080/login.html" page
    When I login with credentials from "emptyEmail"
    Then the "Email" field should show the error "Email is required"

  @TC-TC4
  Scenario: Login attempt with empty password field
    Given I open the "http://localhost:8080/login.html" page
    When I login with credentials from "emptyPassword"
    Then the "Password" field should show the error "Password is required"

  @TC-TC5
  Scenario: Login attempt with Invalid Credentials
    Given I open the "http://localhost:8080/login.html" page
    When I login with credentials from "invalidCredentials"
    Then I should see the text "Invalid credentials"
    And the URL should contain "/login"

  @TC-TC6
  Scenario: Successful Logout
    Given I open the "http://localhost:8080/dashboard" page
    When I click the "Logout" button
    Then the URL should contain "/login"
    And I should see the "Email" field

  @TC-TC7
  Scenario: Unauthorized Access Attempt to a Protected Page
    Given I open the "http://localhost:8080/dashboard" page
    Then the URL should contain "/login"
    And I should see the "Email" field

  @xss-check @TC-TC8
  Scenario: Verify Cross-Site Scripting (XSS) Prevention on Login Fields
    Given I open the "http://localhost:8080/login.html" page
    When I login with credentials from "xssAttempt"
    Then no javascript alert should be present
    And I should see the text "Invalid credentials"

  @TC-TC9
  Scenario: Verify Keyboard Navigation and Form Submission
    Given I open the "http://localhost:8080/login.html" page
    When I press the "Tab" key
    Then the "Email" field is focused
    When I fill "Email" with the value of env "APP_USERNAME"
    And I press the "Tab" key
    Then the "Password" field is focused
    When I fill "Password" with the value of env "APP_PASSWORD"
    And I press the "Tab" key
    Then the "Sign in" button is focused
    When I press the "Enter" key
    Then the URL should contain "/dashboard"
