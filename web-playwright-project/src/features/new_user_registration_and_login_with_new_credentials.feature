@TS-77
Feature: New User Registration and Login

  Background:
    Given I open the "/register" page

  @dryrun @TC-TC1
  Scenario: Successful User Registration
    When I fill "Given name" with "John"
    And I fill "Family name" with "Doe"
    And I fill "Email address" with "{{random.email}}"
    And I fill "Mobile number" with "+1234567890"
    And I fill "Age (years)" with "25"
    And I select "Male" from "Gender identity"
    And I fill "Account password" with "ValidPass123!"
    And I fill "Confirm password" with "ValidPass123!"
    And I check "I accept the terms and conditions"
    And I click the "Create account" button
    Then the URL should contain "/login"
    And I should see the text "Registration successful"

  @TC-TC2
  Scenario: Successful Login After Registration
    When I register a new user with email "{{random.email}}" and password "ValidPass123!"
    And I open the "/login" page
    And I fill "Email" with "{{registered_email}}"
    And I fill "Password" with "ValidPass123!"
    And I click the "Sign in" button
    Then the URL should contain "/dashboard"

  @TC-TC3
  Scenario: Registration With Empty Required Fields
    When I click the "Create account" button
    Then the "Given name" field should be invalid
    And the "Family name" field should be invalid
    And the "Email address" field should be invalid
    And the "Account password" field should be invalid
    And the "Confirm password" field should be invalid
    And the "Gender identity" field should be invalid
    And the "I accept the terms and conditions" field should be invalid

  @TC-TC4
  Scenario: Invalid Email Format During Registration
    When I fill "Given name" with "Jane"
    And I fill "Family name" with "Smith"
    And I fill "Email address" with "invalid-email"
    And I fill "Mobile number" with "+1234567890"
    And I fill "Age (years)" with "30"
    And I select "Female" from "Gender identity"
    And I fill "Account password" with "ValidPass123!"
    And I fill "Confirm password" with "ValidPass123!"
    And I check "I accept the terms and conditions"
    And I click the "Create account" button
    Then the "Email address" field should be invalid

  @TC-TC5
  Scenario: Empty Username or Password During Login
    Given I open the "/login" page
    When I click the "Sign in" button
    Then the "Email" field should be invalid
    And the "Password" field should be invalid

  @TC-TC6
  Scenario: Incorrect Login Credentials
    Given I open the "/login" page
    When I fill "Email" with "wrong@example.com"
    And I fill "Password" with "WrongPass123!"
    And I click the "Sign in" button
    Then I should see the text "Invalid email or password"

  @TC-TC7
  Scenario: Presence of All Required Fields on Registration Page
    Then I should see the text "Given name"
    And I should see the text "Family name"
    And I should see the text "Email address"
    And I should see the text "Account password"
    And I should see the text "Confirm password"
    And I should see the "Create account" button

  @TC-TC8
  Scenario: Presence of All Required Fields on Login Page
    Given I open the "/login" page
    Then I should see the text "Email"
    And I should see the text "Password"
    And I should see the "Sign in" button

  @TC-TC9
  Scenario: Direct Access to Registration Page
    Given I open the "/register" page
    Then I should see the text "Register"

  @TC-TC10
  Scenario: Direct Access to Login Page
    Given I open the "/login" page
    Then I should see the text "Sign in"

  @TC-TC11
  Scenario: Redirect to Dashboard After Successful Login
    Given I open the "/login" page
    When I fill "Email" with "${APP_USERNAME}"
    And I fill "Password" with "${APP_PASSWORD}"
    And I click the "Sign in" button
    Then the URL should contain "/dashboard"

  @TC-TC12
  Scenario: Unauthenticated Access to Dashboard Redirects to Login
    Given I open the "/dashboard" page
    Then the URL should contain "/login"

  @TC-TC13
  Scenario: Script Injection in Registration Fields
    When I fill "Given name" with "<script>alert('XSS')</script>"
    And I fill "Family name" with "Test"
    And I fill "Email address" with "<script>alert('XSS')</script>@example.com"
    And I fill "Mobile number" with "+1234567890"
    And I fill "Age (years)" with "25"
    And I select "Male" from "Gender identity"
    And I fill "Account password" with "<script>alert('XSS')</script>Password123!"
    And I fill "Confirm password" with "<script>alert('XSS')</script>Password123!"
    And I check "I accept the terms and conditions"
    And I click the "Create account" button
    Then the URL should not contain "/dashboard"

  @TC-TC14
  Scenario: Script Injection in Login Fields
    Given I open the "/login" page
    When I fill "Email" with "<script>alert('XSS')</script>@example.com"
    And I fill "Password" with "<script>alert('XSS')</script>Password123!"
    And I click the "Sign in" button
    Then I should not see the text "<script>alert('XSS')</script>"
    And the URL should not contain "/dashboard"
