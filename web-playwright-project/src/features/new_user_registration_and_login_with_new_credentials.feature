@TS-81
Feature: New User Registration and Login with New Credentials

  Background:
    Given I open the "/register" page

  @dryrun @TC-TC1
  Scenario: User registers with valid new credentials and sees success message with login link
    When I fill "Email address" with "{{random.email}}"
    And I fill "Account password" with "Password123!"
    And I fill "Confirm password" with "Password123!"
    And I fill "First name" with "{{random.firstName}}"
    And I fill "Last name" with "{{random.lastName}}"
    And I fill "Age (years)" with "25"
    And I select "Male" from "Gender identity"
    And I check "I accept the terms and conditions"
    And I click the "Create account" button
    Then I should see the text "Registration successful! Please login."
    And I should see the "Sign in" link

  @TC-TC2
  Scenario: User clicks login link after registration and logs in with newly created credentials to reach the dashboard
    When I fill "Email address" with "{{random.email}}"
    And I fill "Account password" with "Password123!"
    And I fill "Confirm password" with "Password123!"
    And I fill "First name" with "{{random.firstName}}"
    And I fill "Last name" with "{{random.lastName}}"
    And I fill "Age (years)" with "25"
    And I select "Male" from "Gender identity"
    And I check "I accept the terms and conditions"
    And I click the "Create account" button
    And I click the "Sign in" link
    And I fill "Email" with "{{random.email}}"
    And I fill "Password" with "Password123!"
    And I click the "Sign in" button
    Then the URL should contain "/dashboard"
    And I should see the text "Welcome"

  @TC-TC3
  Scenario: User submits empty registration form and sees inline errors for all required fields
    When I click the "Create account" button
    Then the "Email address" field should be invalid
    And the "Account password" field should be invalid
    And the "Confirm password" field should be invalid
    And the "First name" field should be invalid
    And the "Last name" field should be invalid
    And the "Age (years)" field should be invalid
    And the "Gender identity" field should be invalid
    And the "I accept the terms and conditions" field should be invalid

  @TC-TC4
  Scenario: User enters invalid email format during registration and sees email validation error
    When I fill "Email address" with "{{negative.email}}"
    And I fill "Account password" with "Password123!"
    And I fill "Confirm password" with "Password123!"
    And I fill "First name" with "{{random.firstName}}"
    And I fill "Last name" with "{{random.lastName}}"
    And I fill "Age (years)" with "25"
    And I select "Male" from "Gender identity"
    And I check "I accept the terms and conditions"
    And I click the "Create account" button
    Then the "Email address" field should be invalid

  @TC-TC5
  Scenario: User enters mismatched passwords during registration and sees password confirmation error
    When I fill "Email address" with "{{random.email}}"
    And I fill "Account password" with "Password123!"
    And I fill "Confirm password" with "DifferentPass456@"
    And I fill "First name" with "{{random.firstName}}"
    And I fill "Last name" with "{{random.lastName}}"
    And I fill "Age (years)" with "25"
    And I select "Male" from "Gender identity"
    And I check "I accept the terms and conditions"
    And I click the "Create account" button
    Then the "Confirm password" field should be invalid

  @TC-TC6
  Scenario: Registration page displays email, password, and confirm password fields with submit button
    Then I should see the text "Email address"
    And I should see the text "Account password"
    And I should see the text "Confirm password"
    And I should see the "Create account" button

  @TC-TC7
  Scenario: Login page displays email, password fields, and login button
    Given I open the "/login" page
    Then I should see the text "Email"
    And I should see the text "Password"
    And I should see the "Sign in" button

  @TC-TC8
  Scenario: User navigates directly to /register URL and sees the registration form
    Then I should see the text "Email address"
    And I should see the text "Account password"
    And I should see the text "Confirm password"

  @TC-TC9
  Scenario: User navigates directly to /login URL and sees the login form
    Given I open the "/login" page
    Then I should see the text "Email"
    And I should see the text "Password"

  @TC-TC10
  Scenario: User logs in successfully and is redirected to the dashboard page
    Given I open the "/login" page
    When I fill "Email" with the value of env "APP_USERNAME"
    And I fill "Password" with the value of env "APP_PASSWORD"
    And I click the "Sign in" button
    Then the URL should contain "/dashboard"
    And I should see the text "Welcome"

  @TC-TC11
  Scenario: User enters HTML/JavaScript in email field during registration and sees it rendered as plain text
    When I fill "Email address" with "{{security.comment}}"
    And I fill "Account password" with "Password123!"
    And I fill "Confirm password" with "Password123!"
    And I fill "First name" with "{{random.firstName}}"
    And I fill "Last name" with "{{random.lastName}}"
    And I fill "Age (years)" with "25"
    And I select "Male" from "Gender identity"
    And I check "I accept the terms and conditions"
    And I click the "Create account" button
    Then the "Email address" field should be invalid

  @TC-TC12
  Scenario: User enters HTML/JavaScript in password field during registration and sees it masked and not executed
    When I fill "Email address" with "{{random.email}}"
    And I fill "Account password" with "{{security.comment}}"
    And I fill "Confirm password" with "{{security.comment}}"
    And I fill "First name" with "{{random.firstName}}"
    And I fill "Last name" with "{{random.lastName}}"
    And I fill "Age (years)" with "25"
    And I select "Male" from "Gender identity"
    And I check "I accept the terms and conditions"
    And I click the "Create account" button
    Then the "Account password" field should be invalid

  @TC-TC13
  Scenario: Unauthenticated user accessing /dashboard is redirected to login page
    Given I open the "/dashboard" page
    Then the URL should contain "/login"
    And I should see the text "Email"
    And I should see the text "Password"
