@TS-49
Feature: Login and Authentication

  @dryrun @TC-TC2
  Scenario: Successful Login with Valid Credentials
    Given I open the "http://localhost:8080/login.html" page
    When I login with valid credentials
    Then the URL should contain "/dashboard"
    Then I should see the text "Welcome"

  @TC-TC1
  Scenario: Verify Login Page UI Elements
    Given I open the "http://localhost:8080/login.html" page
    Then I should see the "Email" field
    Then I should see the "Password" field
    Then I should see the "Sign in" button

  @TC-TC3
  Scenario: Login attempt with empty email field
    Given I open the "http://localhost:8080/login.html" page
    When I fill "Password" with "anypassword"
    When I click the "Sign in" button
    Then I should see the text "Email is required"

  @TC-TC4
  Scenario: Login attempt with empty password field
    Given I open the "http://localhost:8080/login.html" page
    When I fill "Email" with the value of env "APP_USERNAME"
    When I click the "Sign in" button
    Then I should see the text "Password is required"

  @TC-TC5
  Scenario: Login attempt with Invalid Credentials
    Given I open the "http://localhost:8080/login.html" page
    When I fill "Email" with "invalid_user_12345"
    When I fill "Password" with "invalid_password_12345"
    When I click the "Sign in" button
    Then I should see the text "Invalid credentials"
    Then the URL should contain "/login.html"

  @TC-TC6
  Scenario: Successful Logout
    Given I open the "http://localhost:8080/dashboard" page
    When I click the "Logout" button
    Then the URL should contain "/login.html"
    Then I should see the "Email" field

  @TC-TC7
  Scenario: Unauthorized Access Attempt to a Protected Page
    Given I open the "http://localhost:8080/dashboard" page
    Then the URL should contain "/login.html"
    Then I should see the "Email" field

  @TC-TC8
  Scenario: Verify Cross-Site Scripting (XSS) Prevention on Login Fields
    Given I open the "http://localhost:8080/login.html" page
    When I fill "Email" with "<script>alert('XSS')</script>"
    When I fill "Password" with "anypassword"
    When I click the "Sign in" button
    Then no javascript alert should have appeared
    Then I should see the text "Invalid credentials"

  @TC-TC9
  Scenario: Verify Keyboard Navigation and Form Submission
    Given I open the "http://localhost:8080/login.html" page
    When I fill "Email" with the value of env "APP_USERNAME"
    When I press the "Tab" key
    When I fill "Password" with the value of env "APP_PASSWORD"
    When I press the "Tab" key
    When I press the "Enter" key
    Then the URL should contain "/dashboard"