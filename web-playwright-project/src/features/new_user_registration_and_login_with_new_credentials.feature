@TS-76
Feature: User Registration and Login
  Background:
    Given I open the "/register" page

  @dryrun @TC-TC1
  Scenario: Successful User Registration
    When I fill "Given name" with "John"
    And I fill "Family name" with "Doe"
    And I fill "Email address" with "john.doe@example.com"
    And I fill "Account password" with "Password123!"
    And I fill "Confirm password" with "Password123!"
    And I select "Male" from "Gender identity"
    And I fill "Age (years)” with "25"
    And I check "I accept the terms and conditions"
    And I click the "Create account" button
    Then the URL should contain "/login"
    And I should see the text "Registration successful"

  @TC-TC2
  Scenario: Registration with Missing Required Fields
    When I click the "Create account" button
    Then the "Given name" field should be invalid
    And the "Family name" field should be invalid
    And the "Email address" field should be invalid
    And the "Account password" field should be invalid
    And the "Confirm password" field should be invalid
    And the "Gender identity" field should be invalid
    And the "Age (years)” field should be invalid
    And the "I accept the terms and conditions" field should be invalid

  @TC-TC3
  Scenario: XSS Script Injection During Registration
    When I fill "Given name" with "<script>alert('xss')</script>"
    And I fill "Family name" with "<script>alert('xss')</script>"
    And I fill "Email address" with "{{random.email}}"
    And I fill "Account password" with "ValidPass123!"
    And I fill "Confirm password" with "ValidPass123!"
    And I select "Male" from "Gender identity"
    And I fill "Age (years)” with "25"
    And I check "I accept the terms and conditions"
    And I click the "Create account" button
    Then the URL should contain "/login"

  @TC-TC4
  Scenario: Login After Successful Registration
    Given I open the "/login" page
    When I fill "Email" with "john.doe@example.com"
    And I fill "Password" with "Password123!"
    And I click the "Sign in" button
    Then the URL should contain "/dashboard"

  @TC-TC5
  Scenario: Login With Empty Credentials
    Given I open the "/login" page
    When I click the "Sign in" button
    Then the "Email" field should be invalid
    And the "Password" field should be invalid

  @TC-TC6
  Scenario: Direct Dashboard Access Without Authentication
    Given I open the "/dashboard" page
    Then the URL should contain "/login"
    And I should see the text "Please log in to continue"