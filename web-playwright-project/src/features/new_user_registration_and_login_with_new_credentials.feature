@TS-83
Feature: New User Registration and Login with New Credentials
  As a new user
  I want to register and then log in with my new credentials
  So that I can access the user dashboard

  Background:
    Given I open the "/register" page

  @dryrun @TC-TC1
  Scenario: User completes all registration fields and sees success message
    When I fill "First name" with "John"
    And I fill "Last name" with "Doe"
    And I fill "Email address" with "john.doe@example.com"
    And I fill "Age (years)" with "25"
    And I select "Male" from "Gender identity"
    And I fill "Account password" with "SecurePass123!"
    And I fill "Confirm password" with "SecurePass123!"
    And I check "I accept the terms and conditions"
    And I click the "Create account" button
    Then I should see the text "Registration successful"
    And I should see the "Sign in" link

  @TC-TC2
  Scenario: User leaves required fields empty and sees inline errors
    When I click the "Create account" button
    Then the "First name" field should be invalid
    And the "Last name" field should be invalid
    And the "Email address" field should be invalid
    And the "Age (years)" field should be invalid
    And the "Gender identity" field should be invalid
    And the "Account password" field should be invalid
    And the "Confirm password" field should be invalid
    And the "I accept the terms and conditions" field should be invalid

  @TC-TC3
  Scenario: User enters invalid email format and sees an error
    When I fill "First name" with "John"
    And I fill "Last name" with "Doe"
    And I fill "Email address" with "{{negative.email}}"
    And I fill "Age (years)" with "25"
    And I select "Male" from "Gender identity"
    And I fill "Account password" with "SecurePass123!"
    And I fill "Confirm password" with "SecurePass123!"
    And I check "I accept the terms and conditions"
    And I click the "Create account" button
    Then the "Email address" field should be invalid

  @TC-TC4
  Scenario: User submits malicious script in text fields
    When I fill "First name" with "{{security.comment}}"
    And I fill "Last name" with "Smith"
    And I fill "Email address" with "malicious@test.com"
    And I fill "Age (years)" with "25"
    And I select "Male" from "Gender identity"
    And I fill "Account password" with "SafePass123!"
    And I fill "Confirm password" with "SafePass123!"
    And I check "I accept the terms and conditions"
    And I click the "Create account" button
    Then the URL should not contain "/dashboard"

  @TC-TC5
  Scenario: User clicks login link after registration
    When I click the "Sign in" link
    Then the URL should contain "/login"

  @TC-TC6
  Scenario: Registered user logs in and accesses dashboard
    When I fill "Email" with "john.doe@example.com"
    And I fill "Password" with "SecurePass123!"
    And I click the "Sign in" button
    Then the URL should contain "/dashboard"

  @TC-TC7
  Scenario: Unauthenticated access to dashboard redirects to login
    Given I open the "/dashboard" page
    Then the URL should contain "/login"

  @TC-TC8
  Scenario: Registration page displays all expected fields
    Then I should see the text "First name"
    And I should see the text "Last name"
    And I should see the text "Email address"
    And I should see the text "Account password"
    And I should see the "Create account" button

  @TC-TC9
  Scenario: Successful registration shows correct confirmation message
    When I fill "First name" with "Jane"
    And I fill "Last name" with "Doe"
    And I fill "Email address" with "jane.doe@example.com"
    And I fill "Age (years)" with "30"
    And I select "Female" from "Gender identity"
    And I fill "Account password" with "SecurePass456@"
    And I fill "Confirm password" with "SecurePass456@"
    And I check "I accept the terms and conditions"
    And I click the "Create account" button
    Then I should see the text "Registration successful"
    And I should see the "Sign in" link

  @TC-TC10
  Scenario: Form fields are keyboard accessible
    When I press the "Tab" key
    And I press the "Tab" key
    And I press the "Tab" key
    And I press the "Tab" key
    And I press the "Tab" key
    And I press the "Tab" key
    And I press the "Tab" key
    And I press the "Tab" key
    And I press the "Tab" key
    And I press the "Tab" key
    And I press the "Tab" key
    Then the "Create account" button should be focused