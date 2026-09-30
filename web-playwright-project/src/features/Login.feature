@TS-51
Feature: Login Functionality
  As a user
  I want to log in to the application
  So I can access my account and its features

  Background:
    Given I open the "http://localhost:8080/login.html" page

  @dryrun @TC-TC1
  Scenario: Successful login with valid credentials
    When I fill "Email" with the value of env "APP_USERNAME"
    And I fill "Password" with the value of env "APP_PASSWORD"
    And I click the "Sign in" button
    Then the URL should contain "/dashboard"

  @TC-TC2
  Scenario: Verify no welcome message with email after login
    When I fill "Email" with the value of env "APP_USERNAME"
    And I fill "Password" with the value of env "APP_PASSWORD"
    And I click the "Sign in" button
    Then the URL should contain "/dashboard"
    And I should not see a welcome message for the user

  @TC-TC3
  Scenario: Login attempt with invalid credentials
    When I fill "Email" with "invalid-user@example.com"
    And I fill "Password" with "wrongpassword123"
    And I click the "Sign in" button
    Then I should see the text "Error: Invalid credentials"

  @TC-TC4
  Scenario: Login attempt with empty username field
    When I fill "Password" with the value of env "APP_PASSWORD"
    And I click the "Sign in" button
    Then I should see the text "Error: Email is required"

  @TC-TC5
  Scenario: Login attempt with empty password field
    When I fill "Email" with the value of env "APP_USERNAME"
    And I click the "Sign in" button
    Then I should see the text "Error: Password is required"

  @TC-TC6
  Scenario: Verify login page UI elements are present
    Then I should see the "Email" field
    And I should see the "Password" field
    And I should see the "Sign in" button

  @TC-TC7
  Scenario: Verify password field input is masked
    When I fill "Password" with "mysecretpassword"
    Then the "Password" field should be masked

  @TC-TC8
  Scenario: Login attempt with XSS script in username field
    When I fill "Email" with "<script>alert('xss')</script>"
    And I fill "Password" with the value of env "APP_PASSWORD"
    And I click the "Sign in" button
    Then I should see the text "Error: Invalid credentials"
