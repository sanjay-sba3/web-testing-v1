@TS-70
Feature: New User Registration and Login

  Background:
    Given I open the "http://localhost:3000/" page

  @TC-TC1
  Scenario: Verify registration page UI elements are visible
    Given I open the "http://localhost:3000/register" page
    Then I should see the "Given name" textbox
    Then I should see the "Email address" textbox
    Then I should see the "Account password" textbox
    Then I should see the "Confirm password" textbox
    Then I should see the "Create account" button

  @TC-TC2
  Scenario: Verify registration fails with all empty fields
    Given I open the "http://localhost:3000/register" page
    When I click the "Create account" button
    Then the "Given name" field should be invalid
    Then the "Family name" field should be invalid
    Then the "Email address" field should be invalid
    Then the "Age (years)" field should be invalid
    Then the "Gender identity" field should be invalid
    Then the "Account password" field should be invalid
    Then the "I accept the terms and conditions" field should be invalid
    Then the URL should contain "/register"

  @TC-TC3
  Scenario: Verify registration fails with an invalid email format
    Given I open the "http://localhost:3000/register" page
    When I fill "Given name" with "{{random.firstName}}"
    And I fill "Family name" with "{{random.lastName}}"
    And I fill "Email address" with "{{negative.email}}"
    And I fill "Age (years)" with "30"
    And I select "Male" from "Gender identity"
    And I fill "Account password" with "ValidPassword123!"
    And I fill "Confirm password" with "ValidPassword123!"
    And I check "I accept the terms and conditions"
    When I click the "Create account" button
    Then the "Email address" field should be invalid
    And the URL should contain "/register"

  @TC-TC4
  Scenario: Verify registration fails with non-matching passwords
    Given I open the "http://localhost:3000/register" page
    When I fill "Given name" with "testuser_mismatch"
    And I fill "Family name" with "{{random.lastName}}"
    And I fill "Email address" with "{{random.email}}"
    And I fill "Age (years)" with "30"
    And I select "Male" from "Gender identity"
    And I fill "Account password" with "Password123"
    And I fill "Confirm password" with "Password456"
    And I check "I accept the terms and conditions"
    When I click the "Create account" button
    Then the "Confirm password" field should be invalid
    And the URL should contain "/register"

  @TC-TC5
  Scenario: Verify password and confirm password fields are masked
    Given I open the "http://localhost:3000/register" page
    When I fill "Account password" with "aSecretPassword"
    Then the "Account password" field should be masked
    When I fill "Confirm password" with "aSecretPassword"
    Then the "Confirm password" field should be masked

  @checks-for-dialog @TC-TC6
  Scenario: Verify script injection is handled in registration form fields
    Given I open the "http://localhost:3000/register" page
    When I fill "Given name" with "{{security.comment}}"
    And I fill "Family name" with "{{random.lastName}}"
    And I fill "Email address" with "{{random.email}}"
    And I fill "Age (years)" with "30"
    And I select "Male" from "Gender identity"
    And I fill "Account password" with "ValidPassword123!"
    And I fill "Confirm password" with "ValidPassword123!"
    And I check "I accept the terms and conditions"
    And I click the "Create account" button
    Then no alert dialog should appear
    And the URL should contain "/login"

  @TC-TC7
  Scenario: Verify 'Sign in' link on registration page navigates to the login page
    Given I open the "http://localhost:3000/register" page
    When I click the "Sign in" link
    Then the URL should contain "/login"

  @dryrun @TC-TC8
  Scenario: Verify successful user registration redirects to login page
    Given I open the "http://localhost:3000/register" page
    When I register a new user with valid details
    Then the URL should contain "/login"

  @TC-TC9
  Scenario: Verify login page UI elements are visible
    Given I open the "http://localhost:3000/login" page
    Then I should see the "Email" textbox
    Then I should see the "Password" textbox
    Then I should see the "Sign in" button

  @TC-TC10
  Scenario: Verify login fails with empty email and password fields
    Given I open the "http://localhost:3000/login" page
    When I click the "Sign in" button
    Then the "Email" field should be invalid
    And the "Password" field should be invalid
    And the URL should contain "/login"

  @TC-TC11
  Scenario: Verify password field on login page is masked
    Given I open the "http://localhost:3000/login" page
    When I fill "Password" with "any-password"
    Then the "Password" field should be masked

  @TC-TC12
  Scenario: Verify login fails with invalid credentials
    Given I open the "http://localhost:3000/login" page
    When I fill "Email" with "{{random.email}}"
    And I fill "Password" with "invalidpassword"
    And I click the "Sign in" button
    Then I should see the text "Invalid credentials"
    And the URL should contain "/login"

  @TC-TC13
  Scenario: Verify successful login with valid credentials redirects to dashboard
    Given I open the "http://localhost:3000/login" page
    When I fill "Email" with the value of env "APP_USERNAME"
    And I fill "Password" with the value of env "APP_PASSWORD"
    And I click the "Sign in" button
    Then the URL should contain "/dashboard"

  # needs-review: The /dashboard page is not captured; cannot confirm redirection target or elements.
  @needs-review @TC-TC14
  Scenario: Verify unauthenticated user is redirected from dashboard to login
    Given I open the "http://localhost:3000/dashboard" page
    Then the URL should contain "/login"

  @TC-TC15
  Scenario: Verify 'Register' link on login page navigates to the registration page
    Given I open the "http://localhost:3000/login" page
    When I click the "Register now" link
    Then the URL should contain "/register"
