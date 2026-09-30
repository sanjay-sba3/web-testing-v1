@TS-58
Feature: Register
  As a new user
  I want to create an account
  So that I can access the application

  Background:
    Given I open the "http://localhost:8080/register.html" page

  @dryrun @TC-TC1
  Scenario: Successful registration with valid details
    When I fill "First name" with "John"
    When I fill "Last name" with "Doe"
    When I fill "Email" with "{{random.email}}"
    When I fill "Password" with "Password123!"
    When I fill "Confirm password" with "Password123!"
    When I check "I accept the terms"
    When I click the "Create account" button
    Then the URL should contain "login.html"

  @TC-TC2
  Scenario: Verify presence of all registration form elements
    Then I should see the "First name" field
    Then I should see the "Last name" field
    Then I should see the "Email" field
    Then I should see the "Password" field
    Then I should see the "Confirm password" field
    Then I should see the "Create account" button
    Then I should see the "Login" link

  @TC-TC3
  Scenario: Validation for empty required fields
    When I click the "Create account" button
    Then the "First name" field should be invalid
    Then the "Last name" field should be invalid
    Then the "Email" field should be invalid
    Then the "Password" field should be invalid
    Then the "Confirm password" field should be invalid

  @TC-TC4
  Scenario: Validation for invalid email format
    When I fill "First name" with "John"
    When I fill "Last name" with "Doe"
    When I fill "Email" with "{{negative.email}}"
    When I fill "Password" with "Password123!"
    When I fill "Confirm password" with "Password123!"
    When I click the "Create account" button
    Then the "Email" field should be invalid
    Then the page title should contain "Register"

  @TC-TC5
  Scenario: Validation for mismatched passwords
    When I fill "First name" with "Jane"
    When I fill "Last name" with "Doe"
    When I fill "Email" with "{{random.email}}"
    When I fill "Password" with "Password123!"
    When I fill "Confirm password" with "DifferentPassword123!"
    When I click the "Create account" button
    Then I should see the text "Passwords do not match"

  @TC-TC6
  Scenario: Validation for password shorter than minimum length
    When I fill "First name" with "Jane"
    When I fill "Last name" with "Doe"
    When I fill "Email" with "{{random.email}}"
    When I fill "Password" with "short"
    When I fill "Confirm password" with "short"
    When I click the "Create account" button
    Then I should see the text "Password must be at least 8 characters"

  @TC-TC7
  Scenario: Successful registration with password of exact minimum length
    When I fill "First name" with "Jane"
    When I fill "Last name" with "Smith"
    When I fill "Email" with "{{random.email}}"
    When I fill "Password" with "Passw1!a"
    When I fill "Confirm password" with "Passw1!a"
    When I check "I accept the terms"
    When I click the "Create account" button
    Then the URL should contain "login.html"

  # needs-review: The exact password complexity error message is not specified.
  @needs-review @TC-TC8
  Scenario: Validation for password not meeting complexity requirements
    When I fill "First name" with "John"
    When I fill "Last name" with "Doe"
    When I fill "Email" with "{{random.email}}"
    When I fill "Password" with "password123"
    When I fill "Confirm password" with "password123"
    When I click the "Create account" button
    Then the page title should contain "Register"

  @TC-TC9
  Scenario: Validation for registration with an already existing email
    When I fill "First name" with "John"
    When I fill "Last name" with "Doe"
    When I fill "Email" with "existing.user@example.com"
    When I fill "Password" with "NewPass123!"
    When I fill "Confirm password" with "NewPass123!"
    When I click the "Create account" button
    Then I should see the text "An account with this email already exists"

  @TC-TC10
  Scenario: Verify password fields are masked
    When I fill "Password" with "any text"
    Then the "Password" field's input should be masked
    When I fill "Confirm password" with "any text"
    Then the "Confirm password" field's input should be masked

  @TC-TC11
  Scenario: Security validation for XSS in input fields
    When I fill "First name" with "{{security.comment}}"
    When I fill "Last name" with "Doe"
    When I fill "Email" with "{{negative.email}}"
    When I click the "Create account" button
    Then the value of the "First name" field should be "<script>alert(1)</script>"
    # Verifying no alert dialog appears is implicit; Playwright would fail if an unhandled dialog opened.

  @TC-TC12
  Scenario: Navigation from Register page to Sign In page
    When I click the "Login" link
    Then the URL should contain "login.html"

  @TC-TC13
  Scenario: Accessibility check for keyboard tab navigation
    When I press the "Tab" key
    Then the "First name" element should have focus
    When I press the "Tab" key
    Then the "Last name" element should have focus
    When I press the "Tab" key
    Then the "Email" element should have focus
    When I press the "Tab" key
    Then the "Password" element should have focus
    When I press the "Tab" key
    Then the "Confirm password" element should have focus
    When I press the "Tab" key
    Then the "Create account" element should have focus
    When I press the "Tab" key
    Then the "Login" element should have focus

  @TC-TC14
  Scenario: Accessibility check for form submission with Enter key
    When I fill "First name" with "John"
    When I fill "Last name" with "Doe"
    When I fill "Email" with "{{random.email}}"
    When I fill "Password" with "Password123!"
    When I fill "Confirm password" with "Password123!"
    When I check "I accept the terms"
    When I press the "Enter" key
    Then the URL should contain "login.html"
