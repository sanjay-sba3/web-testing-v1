@TS-78
Feature: User Registration and Login

  Background:
    Given I open the "/register" page

  @dryrun @TC-TC1
  Scenario: Register new user with valid data
    When I fill "Given name" with "John"
    And I fill "Family name" with "Doe"
    And I fill "Email address" with "johndoe@example.com"
    And I fill "Age (years)" with "25"
    And I select "Male" from "Gender identity"
    And I fill "Account password" with "SecurePass123!"
    And I fill "Confirm password" with "SecurePass123!"
    And I check "I accept the terms and conditions"
    And I click the "Create account" button
    Then the URL should contain "/dashboard"

  @TC-TC2
  Scenario: Attempt registration with empty fields
    When I click the "Create account" button
    Then the "Given name" field should be invalid
    And the "Family name" field should be invalid
    And the "Email address" field should be invalid
    And the "Age (years)" field should be invalid
    And the "Gender identity" field should be invalid
    And the "Account password" field should be invalid
    And the "Confirm password" field should be invalid
    And the "I accept the terms and conditions" field should be invalid

  @TC-TC3
  Scenario: Registration with invalid email format
    When I fill "Given name" with "John"
    And I fill "Family name" with "Doe"
    And I fill "Email address" with "invalid-email-format"
    And I fill "Age (years)" with "25"
    And I select "Male" from "Gender identity"
    And I fill "Account password" with "SecurePass123!"
    And I fill "Confirm password" with "SecurePass123!"
    And I check "I accept the terms and conditions"
    And I click the "Create account" button
    Then the "Email address" field should be invalid

  @TC-TC4
  # needs-review: no Username field on register.html
  @needs-review @TC-TC4
  Scenario: Verify registration page fields presence
    Then I should see the text "Tell us a little about yourself"
    And I should see the "Create account" button

  @TC-TC5
  Scenario: Navigate to login page from registration page
    When I click the "Sign in" link
    Then the URL should contain "/login"

  @TC-TC6
  Scenario: Successful login with newly registered user
    Given I register a new user
    When I open the "/login" page
    And I fill "Email" with the value of env "NEW_USER_EMAIL"
    And I fill "Password" with the value of env "NEW_USER_PASSWORD"
    And I click the "Sign in" button
    Then the URL should contain "/dashboard"

  @TC-TC7
  Scenario: Login with empty username or password
    When I click the "Sign in" button
    Then the "Email" field should be invalid
    And the "Password" field should be invalid

  @TC-TC8
  Scenario: Login with invalid credentials
    When I fill "Email" with "fake_user@example.com"
    And I fill "Password" with "wrong_password"
    And I click the "Sign in" button
    Then I should see the text "Invalid email or password"

  @TC-TC9
  Scenario: XSS attack in registration form fields
    When I fill "Given name" with "<script>alert('xss')</script>"
    And I fill "Family name" with "<img src=x onerror=alert('xss')>"
    And I fill "Email address" with "<script>alert('xss')</script>@example.com"
    And I fill "Age (years)" with "25"
    And I select "Male" from "Gender identity"
    And I fill "Account password" with "<script>alert('xss')</script>"
    And I fill "Confirm password" with "<script>alert('xss')</script>"
    And I check "I accept the terms and conditions"
    And I click the "Create account" button
    Then the URL should not contain "/dashboard"

  @TC-TC10
  Scenario: XSS attack in login form fields
    When I fill "Email" with "<script>alert('xss')</script>"
    And I fill "Password" with "<script>alert('xss')</script>"
    And I click the "Sign in" button
    Then I should see the text "Invalid email or password"

  @TC-TC11
  Scenario: Unauthenticated access to dashboard redirects to login
    When I open the "/dashboard" page
    Then the URL should contain "/login"

  @TC-TC12
  Scenario: Keyboard accessibility on registration and login pages
    When I press the "Tab" key
    And I press the "Tab" key
    And I press the "Tab" key
    And I press the "Enter" key
    Then I should see the text "Already have an account?"
    When I open the "/login" page
    And I press the "Tab" key
    And I press the "Tab" key
    And I press the "Enter" key
    Then I should see the text "Don't have an account?"

  @TC-TC13
  Scenario: Responsive design on mobile devices
    When I open the "/register" page
    Then I should see the text "Tell us a little about yourself"
    When I open the "/login" page
    Then I should see the text "Enter your details to continue"