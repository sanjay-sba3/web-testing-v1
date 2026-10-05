@TS-77
Feature: User Registration and Login

  Background:
    Given I open the "/register" page

  @dryrun @TC-TC1
  Scenario: Successful User Registration
    When I fill "Given name" with "{{random.firstName}}"
    And I fill "Family name" with "{{random.lastName}}"
    And I fill "Email address" with "{{random.email}}"
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
    When I register a new user
    And I open the "/login" page
    And I fill "Email address" with the registered email
    And I fill "Password" with the registered password
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
    And the "I accept the terms and conditions" field should be invalid

  @TC-TC4
  Scenario: Invalid Email Format During Registration
    When I fill "Given name" with "John"
    And I fill "Family name" with "Doe"
    And I fill "Email address" with "{{negative.email}}"
    And I fill "Age (years)" with "25"
    And I select "Male" from "Gender identity"
    And I fill "Account password" with "ValidPass123!"
    And I fill "Confirm password" with "ValidPass123!"
    And I check "I accept the terms and conditions"
    And I click the "Create account" button
    Then the "Email address" field should be invalid

  @TC-TC13
  Scenario: Script Injection in Registration Fields
    When I fill "Given name" with "<script>alert(1)</script>"
    And I fill "Family name" with "{{random.lastName}}"
    And I fill "Email address" with "<script>alert(1)</script>@example.com"
    And I fill "Age (years)" with "25"
    And I select "Male" from "Gender identity"
    And I fill "Account password" with "<script>alert(1)</script>"
    And I fill "Confirm password" with "<script>alert(1)</script>"
    And I check "I accept the terms and conditions"
    And I click the "Create account" button
    Then the URL should not contain "/dashboard"

  @TC-TC7
  Scenario: Presence of All Required Fields on Registration Page
    Then I should see the text "Given name"
    And I should see the text "Family name"
    And I should see the text "Email address"
    And I should see the text "Account password"
    And I should see the text "Confirm password"
    And I should see the "Create account" button

  @TC-TC9
  Scenario: Direct Access to Registration Page
    Given I open the "/register" page
    Then I should see the text "Register"

  @TC-TC11
  Scenario: Redirect to Dashboard After Successful Login
    Given I open the "/login" page
    When I fill "Email address" with the value of env "APP_USERNAME"
    And I fill "Password" with the value of env "APP_PASSWORD"
    And I click the "Sign in" button
    Then the URL should contain "/dashboard"

  @TC-TC12
  Scenario: Unauthenticated Access to Dashboard Redirects to Login
    Given I open the "/dashboard" page
    Then the URL should contain "/login"

  @TC-TC14
  Scenario: Script Injection in Login Fields
    Given I open the "/login" page
    When I fill "Email address" with "<script>alert(1)</script>@example.com"
    And I fill "Password" with "<script>alert(1)</script>"
    And I click the "Sign in" button
    Then the URL should contain "/login"

  @TC-TC5
  Scenario: Empty Username or Password During Login
    Given I open the "/login" page
    When I click the "Sign in" button
    Then the "Email address" field should be invalid
    And the "Password" field should be invalid

  @TC-TC6
  Scenario: Incorrect Login Credentials
    Given I open the "/login" page
    When I fill "Email address" with "wrong@example.com"
    And I fill "Password" with "WrongPass123!"
    And I click the "Sign in" button
    Then I should see the text "Invalid email or password"

  @TC-TC8
  Scenario: Presence of All Required Fields on Login Page
    Given I open the "/login" page
    Then I should see the text "Email address"
    And I should see the text "Password"
    And I should see the "Sign in" button

  @TC-TC10
  Scenario: Direct Access to Login Page
    Given I open the "/login" page
    Then I should see the text "Sign in"