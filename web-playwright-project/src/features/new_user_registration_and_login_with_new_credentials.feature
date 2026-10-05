@TS-80
Feature: User Registration and Login
  As a new user
  I want to register and log in to the application
  So that I can access my personalized dashboard

  Background:
    Given I open the "/register" page

  @dryrun @TC-TC1
  Scenario: Successful User Registration and Login
    When I fill "First name" with "John"
    And I fill "Last name" with "Doe"
    And I fill "Email address" with "johndoe@example.com"
    And I fill "Account password" with "Password123!"
    And I fill "Confirm password" with "Password123!"
    And I select "Male" from "Gender identity"
    And I fill "Age (years)" with "25"
    And I check "I accept the terms and conditions"
    And I click the "Create account" button
    Then the URL should not contain "/register"
    When I click the "Sign in" link
    Then the URL should contain "/login"
    When I fill "Email" with "johndoe@example.com"
    And I fill "Password" with "Password123!"
    And I click the "Sign in" button
    Then the URL should contain "/dashboard"

  @TC-TC2
  Scenario: Registration with Missing Required Fields
    When I click the "Create account" button
    Then the "First name" field should be invalid
    And the "Last name" field should be invalid
    And the "Email address" field should be invalid
    And the "Account password" field should be invalid
    And the "Confirm password" field should be invalid
    And the "Gender identity" field should be invalid
    And the "Age (years)" field should be invalid
    And the "I accept the terms and conditions" field should be invalid

  @TC-TC3
  Scenario: Registration with Invalid Email Format
    When I fill "First name" with "John"
    And I fill "Last name" with "Doe"
    And I fill "Email address" with "invalid-email"
    And I fill "Account password" with "Password123!"
    And I fill "Confirm password" with "Password123!"
    And I select "Male" from "Gender identity"
    And I fill "Age (years)" with "25"
    And I check "I accept the terms and conditions"
    And I click the "Create account" button
    Then the "Email address" field should be invalid

  @TC-TC4
  Scenario: XSS Script Injection in Registration Form
    When I fill "First name" with "{{security.firstName}}"
    And I fill "Last name" with "Hacker"
    And I fill "Email address" with "{{random.email}}"
    And I fill "Account password" with "Password123!"
    And I fill "Confirm password" with "Password123!"
    And I select "Male" from "Gender identity"
    And I fill "Age (years)" with "25"
    And I check "I accept the terms and conditions"
    And I click the "Create account" button
    Then the URL should not contain "/register"

  @TC-TC5
  Scenario: Presence of All Required Registration Fields
    Then I should see the "First name" field
    And I should see the "Last name" field
    And I should see the "Email address" field
    And I should see the "Account password" field
    And I should see the "Confirm password" field
    And I should see the "Gender identity" field
    And I should see the "Age (years)" field
    And I should see the "I accept the terms and conditions" field

  @TC-TC6
  Scenario: Navigation to Login After Successful Registration
    When I fill "First name" with "Alice"
    And I fill "Last name" with "Smith"
    And I fill "Email address" with "alice@example.com"
    And I fill "Account password" with "SecurePass123!"
    And I fill "Confirm password" with "SecurePass123!"
    And I select "Female" from "Gender identity"
    And I fill "Age (years)" with "30"
    And I check "I accept the terms and conditions"
    And I click the "Create account" button
    Then the URL should not contain "/register"
    When I click the "Sign in" link
    Then the URL should contain "/login"

  @TC-TC7
  Scenario: Redirect to Dashboard After Successful Login
    Given I open the "/login" page
    When I fill "Email" with "user@example.com"
    And I fill "Password" with "ValidPass123!"
    And I click the "Sign in" button
    Then the URL should contain "/dashboard"

  @TC-TC8
  Scenario: Unauthenticated Access to Dashboard Redirects to Login
    Given I open the "/dashboard" page
    Then the URL should contain "/login"

  @TC-TC9
  Scenario: Tab Navigation and Enter Key Submission
    When I press the "Tab" key
    And I fill "First name" with "Bob"
    And I press the "Tab" key
    And I fill "Last name" with "Builder"
    And I press the "Tab" key
    And I fill "Email address" with "bob@example.com"
    And I press the "Tab" key
    And I fill "Account password" with "BuildPass123!"
    And I press the "Tab" key
    And I fill "Confirm password" with "BuildPass123!"
    And I press the "Tab" key
    And I select "Male" from "Gender identity"
    And I press the "Tab" key
    And I fill "Age (years)" with "35"
    And I press the "Tab" key
    And I check "I accept the terms and conditions"
    And I press the "Enter" key
    Then the URL should not contain "/register"