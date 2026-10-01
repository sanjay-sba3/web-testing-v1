@TS-66
Feature: New User Registration and Login

  Background:
    Given I open the "http://localhost:8080/register.html" page

  @dryrun @TC-TC3
  Scenario: Successful user registration and subsequent login
    When I register a new user with a random email and password "TestPass123!"
    Then the URL should contain "login.html"
    When I log in with the new user's credentials
    And I click the "Sign in" button
    Then the URL should contain "/dashboard"

  @TC-TC1
  Scenario: Verify registration page UI elements are visible
    Then the "Given name" textbox is visible
    And the "Family name" textbox is visible
    And the "Email address" textbox is visible
    And the "Account password" textbox is visible
    And the "Confirm password" textbox is visible
    And I should see the "Create account" button

  @TC-TC2
  Scenario: Verify login page UI elements are visible
    Given I open the "http://localhost:8080/login.html" page
    Then the "Email" textbox is visible
    And the "Password" textbox is visible
    And I should see the "Sign in" button

  @TC-TC4
  Scenario: Registration - Submit with all required fields empty
    When I click the "Create account" button
    Then the "Given name" field should be invalid
    And the "Family name" field should be invalid
    And the "Email address" field should be invalid
    And the "Age (years)" field should be invalid
    And the "Account password" field should be invalid
    And the URL should contain "register.html"

  @TC-TC5
  Scenario: Registration - Submit with non-matching passwords
    When I fill the registration form with valid data but with non-matching passwords
    And I click the "Create account" button
    Then I should see the text "Passwords do not match"
    And the URL should contain "register.html"

  @TC-TC6
  Scenario: Registration - Attempt to register with an existing email
    When I fill the registration form with the existing email "existing.user@example.com"
    And I click the "Create account" button
    Then I should see the text "Username is already taken"
    And the URL should contain "register.html"

  @TC-TC7
  Scenario: Login - Attempt with incorrect password
    Given I open the "http://localhost:8080/login.html" page
    When I fill "Email" with the value of env "APP_USERNAME"
    And I fill "Password" with "wrongpassword123!"
    And I click the "Sign in" button
    Then I should see the text "Login was unsuccessful"
    And the URL should contain "login.html"

  @TC-TC8
  Scenario: Login - Submit with empty email field
    Given I open the "http://localhost:8080/login.html" page
    When I fill "Password" with the value of env "APP_PASSWORD"
    And I click the "Sign in" button
    Then the "Email" field should be invalid
    And the URL should contain "login.html"

  @TC-TC9
  Scenario: Login - Submit with empty password field
    Given I open the "http://localhost:8080/login.html" page
    When I fill "Email" with the value of env "APP_USERNAME"
    And I click the "Sign in" button
    Then the "Password" field should be invalid
    And the URL should contain "login.html"

  @TC-TC10
  Scenario: Authorization - Unauthenticated user access to dashboard
    Given I open the "http://localhost:8080/dashboard" page
    Then the URL should contain "login.html"

  @TC-TC11
  Scenario: Security - Password field input masking
    Then the "Account password" field should be a password field
    And the "Confirm password" field should be a password field
    Given I open the "http://localhost:8080/login.html" page
    Then the "Password" field should be a password field

  # needs-review: The test case expects an error message containing the script, but the system behavior for this is not specified. Assuming it echoes the input in an error.
  @needs-review @TC-TC12
  Scenario: Security - XSS prevention in registration email field
    When I fill the registration form with the existing email "<script>alert('xss')</script>"
    And I click the "Create account" button
    Then I should see the text "<script>alert('xss')</script>"

  @TC-TC13
  Scenario: Accessibility - Keyboard navigation on registration and login forms
    Then I can tab through the registration form fields in order:
      | Field Label                       |
      | Given name                        |
      | Family name                       |
      | Email address                     |
      | Mobile number                     |
      | Age (years)                       |
      | Gender identity                   |
      | Account password                  |
      | Confirm password                  |
      | I accept the terms and conditions |
      | Create account                    |
    Given I open the "http://localhost:8080/login.html" page
    Then I can tab through the login form fields in order:
      | Field Label         |
      | Email               |
      | Password            |
      | Show                |
      | Remember my email   |
      | Create account      |
      | Sign in             |
