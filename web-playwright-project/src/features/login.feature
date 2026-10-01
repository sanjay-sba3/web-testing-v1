@TS-64
Feature: Login Page Functionality

  As a user
  I want to log in to the application
  So that I can access its features

  @dryrun @TC-TC1
  Scenario: Successful login with valid credentials
    Given I open the "http://localhost:8080/login.html" page
    When I fill "Email" with the value of env "APP_USERNAME"
    And I fill "Password" with the value of env "APP_PASSWORD"
    And I click the "Sign in" button
    Then the URL should not contain "login.html"

  @TC-TC2
  Scenario: Verify login page UI elements are present
    Given I open the "http://localhost:8080/login.html" page
    Then the "Email" field should be visible
    And the "Password" field should be visible
    And I should see the "Sign in" button

  @TC-TC3
  Scenario: Login attempt with empty username and password fields
    Given I open the "http://localhost:8080/login.html" page
    When I click the "Sign in" button
    Then the "Email" field should be invalid
    And the "Password" field should be invalid

  @TC-TC4
  Scenario: Login attempt with empty username
    Given I open the "http://localhost:8080/login.html" page
    When I fill "Password" with the value of env "APP_PASSWORD"
    And I click the "Sign in" button
    Then the "Email" field should be invalid

  @TC-TC5
  Scenario: Login attempt with empty password
    Given I open the "http://localhost:8080/login.html" page
    When I fill "Email" with the value of env "APP_USERNAME"
    And I click the "Sign in" button
    Then the "Password" field should be invalid

  @TC-TC6
  Scenario: Login attempt with valid username and incorrect password
    Given I open the "http://localhost:8080/login.html" page
    When I fill "Email" with the value of env "APP_USERNAME"
    And I fill "Password" with "invalidpassword123"
    And I click the "Sign in" button
    Then I should see the text "Invalid credentials"

  @TC-TC7
  Scenario: Login attempt with a non-existent username
    Given I open the "http://localhost:8080/login.html" page
    When I fill "Email" with "nonexistentuser@example.com"
    And I fill "Password" with "anypassword"
    And I click the "Sign in" button
    Then I should see the text "Invalid credentials"

  @TC-TC8
  Scenario: Verify password field input is masked
    Given I open the "http://localhost:8080/login.html" page
    When I fill "Password" with "visiblepassword"
    Then the "Password" field should be masked

  @TC-TC9
  Scenario: Login attempt with script tags in username field
    Given I open the "http://localhost:8080/login.html" page
    When I fill "Email" with "{{security.comment}}"
    And I fill "Password" with "anypassword"
    And I click the "Sign in" button
    Then I should see the text "Invalid credentials"
    And the URL should contain "login.html"

  @TC-TC10
  Scenario: Unauthenticated user is redirected to login from a protected page
    Given I am not logged in
    When I open the "/dashboard" page
    Then the URL should contain "login.html"
    And the page title should contain "Login"

  @TC-TC11
  Scenario: Successful login using keyboard navigation
    Given I open the "http://localhost:8080/login.html" page
    When I fill "Email" with the value of env "APP_USERNAME"
    And I fill "Password" with the value of env "APP_PASSWORD"
    And I press the "Enter" key
    Then the URL should not contain "login.html"

  @TC-TC12
  Scenario: Direct navigation to the login page URL
    Given I open the "http://localhost:8080/login.html" page
    Then the page title should contain "Login"
