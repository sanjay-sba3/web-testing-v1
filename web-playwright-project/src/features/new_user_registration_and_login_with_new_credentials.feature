@TS-84
Feature: User Registration and Login

  Background:
    Given I open the "/register" page

  @dryrun @TC-TC1
  Scenario: Successful Registration with Valid Data
    When I fill "First name" with "John"
    And I fill "Last name" with "Doe"
    And I fill "Email address" with "{{random.email}}"
    And I fill "Account password" with "SecurePass123!"
    And I fill "Confirm password" with "SecurePass123!"
    And I select "Male" from "Gender identity"
    And I check "I accept the terms and conditions"
    And I fill "Age (years)" with "25"
    And I click the "Create account" button
    Then I should see the text "Registration successful"
    And I should see the "Sign in" link

  @TC-TC2
  Scenario: Empty Required Fields Show Inline Errors
    When I click the "Create account" button
    Then the "First name" field should be invalid
    And the "Last name" field should be invalid
    And the "Email address" field should be invalid
    And the "Account password" field should be invalid
    And the "Confirm password" field should be invalid
    And the "Gender identity" field should be invalid
    And the "I accept the terms and conditions" field should be invalid
    And the "Age (years)" field should be invalid

  @TC-TC3
  Scenario: Invalid Email Format Prevents Submission
    When I fill "First name" with "John"
    And I fill "Last name" with "Doe"
    And I fill "Email address" with "invalid-email"
    And I fill "Account password" with "SecurePass123!"
    And I fill "Confirm password" with "SecurePass123!"
    And I select "Male" from "Gender identity"
    And I check "I accept the terms and conditions"
    And I fill "Age (years)" with "25"
    And I click the "Create account" button
    Then the "Email address" field should be invalid

  @TC-TC4
  Scenario: Maximum Username Length Submits Successfully
    When I fill "First name" with "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
    And I fill "Last name" with "BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB"
    And I fill "Email address" with "{{random.email}}"
    And I fill "Account password" with "SecurePass123!"
    And I fill "Confirm password" with "SecurePass123!"
    And I select "Male" from "Gender identity"
    And I check "I accept the terms and conditions"
    And I fill "Age (years)" with "25"
    And I click the "Create account" button
    Then I should see the text "Registration successful"

  @TC-TC5
  Scenario: Exceed Maximum Username Length Shows Error
    When I fill "First name" with "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
    And I fill "Last name" with "BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB"
    And I fill "Email address" with "{{random.email}}"
    And I fill "Account password" with "SecurePass123!"
    And I fill "Confirm password" with "SecurePass123!"
    And I select "Male" from "Gender identity"
    And I check "I accept the terms and conditions"
    And I fill "Age (years)" with "25"
    And I click the "Create account" button
    Then the "First name" field should be invalid

  @TC-TC6
  Scenario: Registration Form Contains All Expected Fields
    Then I should see the text "Tell us a little about yourself"
    And I should see the "First name" field
    And I should see the "Last name" field
    And I should see the "Email address" field
    And I should see the "Mobile number" field
    And I should see the "Age (years)" field
    And I should see the "Gender identity" field
    And I should see the "Account password" field
    And I should see the "Confirm password" field
    And I should see the "I accept the terms and conditions" field
    And I should see the "Create account" button

  @TC-TC7
  Scenario: Clicking Login Link Navigates to Login Page
    When I click the "Sign in" link
    Then the URL should contain "/login"

  @TC-TC9
  Scenario: XSS Script Input Is Rendered Safely
    When I fill "First name" with "{{security.comment}}"
    And I fill "Last name" with "Doe"
    And I fill "Email address" with "{{random.email}}"
    And I fill "Account password" with "SecurePass123!"
    And I fill "Confirm password" with "SecurePass123!"
    And I select "Male" from "Gender identity"
    And I check "I accept the terms and conditions"
    And I fill "Age (years)" with "25"
    And I click the "Create account" button
    Then I should see the text "Registration successful"

  @TC-TC10
  Scenario: Password Field Masks Input While Typing
    When I fill "Account password" with "SecurePass123!"
    Then the "Account password" field should have type "password"

  @TC-TC11
  Scenario: Unauthenticated Access to Dashboard Redirects to Login
    Given I open the "/dashboard" page
    Then the URL should contain "/login"

  @TC-TC13
  Scenario: Form Fields Are Accessible via Keyboard Navigation
    When I press the "Tab" key
    And I press the "Tab" key
    And I press the "Tab" key
    And I press the "Tab" key
    And I press the "Tab" key
    And I press the "Tab" key
    And I press the "Tab" key
    And I press the "Tab" key
    And I press the "Enter" key
    Then the "First name" field should be invalid

  @TC-TC14
  Scenario: Screen Readers Announce Error Messages
    When I click the "Create account" button
    Then the "First name" field should be invalid