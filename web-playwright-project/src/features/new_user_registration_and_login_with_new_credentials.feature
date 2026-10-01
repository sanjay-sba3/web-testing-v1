@TS-73
Feature: New User Registration and Login

  Background:
    Given I open the "http://localhost:3000/register" page

  @dryrun @TC-TC1
  Scenario: Successful user registration and subsequent login
    When I register a new user with valid details
    Then the URL should contain "/login"
    When I log in with the new user credentials
    Then the URL should contain "/dashboard"

  @TC-TC2
  Scenario: Verify registration page UI elements are present
    Then I should see the text "Email address"
    Then I should see the text "Account password"
    Then I should see the text "Confirm password"
    Then I should see the "Create account" button

  @TC-TC3
  Scenario: Verify login page UI elements are present
    Given I open the "http://localhost:3000/login" page
    Then I should see the text "Email"
    Then I should see the text "Password"
    Then I should see the "Sign in" button

  @TC-TC4
  Scenario: Attempt registration with all fields empty
    When I click the "Create account" button
    Then the "Given name" field should be invalid
    Then the "Family name" field should be invalid
    Then the "Email address" field should be invalid
    Then the "Account password" field should be invalid

  @TC-TC5
  Scenario: Attempt registration with an invalid email format
    When I fill "Given name" with "Test"
    When I fill "Family name" with "User"
    When I fill "Email address" with "{{negative.email}}"
    When I fill "Age (years)" with "30"
    When I select "Prefer not to say" from "Gender identity"
    When I fill "Account password" with "ValidPassword123!"
    When I fill "Confirm password" with "ValidPassword123!"
    When I check "I accept the terms and conditions"
    When I click the "Create account" button
    Then the "Email address" field should be invalid

  @TC-TC6
  Scenario: Attempt registration with mismatching passwords
    When I fill "Given name" with "Test"
    When I fill "Family name" with "User"
    When I fill "Email address" with "{{random.email}}"
    When I fill "Age (years)" with "30"
    When I select "Prefer not to say" from "Gender identity"
    When I fill "Account password" with "PasswordA123"
    When I fill "Confirm password" with "PasswordB456"
    When I check "I accept the terms and conditions"
    When I click the "Create account" button
    # needs-review: Page uses browser's 'setCustomValidity', which does not display text. Asserting for invalid field instead.
    Then the "Confirm password" field should be invalid

  @TC-TC7
  Scenario: Attempt registration with an already registered email
    When I fill "Given name" with "Test"
    When I fill "Family name" with "User"
    When I fill "Email address" with the value of env "APP_USERNAME"
    When I fill "Age (years)" with "30"
    When I select "Prefer not to say" from "Gender identity"
    When I fill "Account password" with "AnyValidPassword123"
    When I fill "Confirm password" with "AnyValidPassword123"
    When I check "I accept the terms and conditions"
    When I click the "Create account" button
    # needs-review: The test case expects "user already exists", but the exact text is not specified in the requirements. This may need adjustment.
    Then I should see the text "user already exists"

  @TC-TC8
  Scenario: Attempt login with incorrect credentials
    Given I open the "http://localhost:3000/login" page
    When I fill "Email" with the value of env "APP_USERNAME"
    When I fill "Password" with "IncorrectPassword123!"
    When I click the "Sign in" button
    # needs-review: The test case expects "invalid credentials", but the exact text is not specified in the requirements. This may need adjustment.
    Then I should see the text "invalid credentials"

  @TC-TC9
  Scenario: Attempt login with empty credentials
    Given I open the "http://localhost:3000/login" page
    When I click the "Sign in" button
    Then the "Email" field should be invalid
    Then the "Password" field should be invalid

  @TC-TC10
  Scenario: Unauthorized access attempt to dashboard page
    Given I open the "http://localhost:3000/dashboard" page
    Then the URL should contain "/login"

  @TC-TC11
  Scenario: Verify password fields mask input
    When I fill "Account password" with "MySecretPassword123"
    Then the "Account password" textbox should be masked
    When I fill "Confirm password" with "MySecretPassword123"
    Then the "Confirm password" textbox should be masked
    Given I open the "http://localhost:3000/login" page
    When I fill "Password" with "MySecretPassword123"
    Then the "Password" textbox should be masked

  @TC-TC12
  Scenario: Prevent XSS in registration email field
    When I fill "Given name" with "Test"
    When I fill "Family name" with "User"
    When I fill "Email address" with "{{security.comment}}"
    When I fill "Age (years)" with "30"
    When I select "Prefer not to say" from "Gender identity"
    When I fill "Account password" with "ValidPassword123!"
    When I fill "Confirm password" with "ValidPassword123!"
    When I check "I accept the terms and conditions"
    When I click the "Create account" button
    Then the "Email address" field should be invalid
