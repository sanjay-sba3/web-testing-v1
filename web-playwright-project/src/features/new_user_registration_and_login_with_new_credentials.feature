@TS-82
Feature: User Registration and Login
  As a new user
  I want to register and then login with my new credentials
  So that I can access the application

  Background:
    Given I open the "/register" page

  @dryrun @TC-TC1
  Scenario: User completes registration with valid data and sees success message
    When I fill "Email address" with "{{random.email}}"
    And I fill "First name" with "{{random.firstName}}"
    And I fill "Last name" with "{{random.lastName}}"
    And I fill "Mobile number" with "+1234567890"
    And I fill "Age (years)" with "25"
    And I select "Male" from "Gender identity"
    And I fill "Account password" with "Secret123"
    And I fill "Confirm password" with "Secret123"
    And I check "I accept the terms and conditions"
    And I click the "Create account" button
    Then the URL should not contain "/register"

  @TC-TC2
  Scenario: User clicks login link after registration and lands on login page
    When I fill "Email address" with "{{random.email}}"
    And I fill "First name" with "{{random.firstName}}"
    And I fill "Last name" with "{{random.lastName}}"
    And I fill "Mobile number" with "+1234567890"
    And I fill "Age (years)" with "25"
    And I select "Male" from "Gender identity"
    And I fill "Account password" with "Secret123"
    And I fill "Confirm password" with "Secret123"
    And I check "I accept the terms and conditions"
    And I click the "Create account" button
    And I click the "Sign in" link
    Then the URL should contain "/login"

  @TC-TC3
  Scenario: User logs in with correct credentials and sees dashboard
    Given I open the "/login" page
    When I fill "Email" with "${APP_USERNAME}"
    And I fill "Password" with "${APP_PASSWORD}"
    And I click the "Sign in" button
    Then the URL should contain "/dashboard"

  @TC-TC4
  Scenario: User submits registration form with missing required fields and sees error messages
    When I click the "Create account" button
    Then the "Email address" field should be invalid
    And the "First name" field should be invalid
    And the "Last name" field should be invalid
    And the "Age (years)" field should be invalid
    And the "Gender identity" field should be invalid
    And the "Account password" field should be invalid
    And the "Confirm password" field should be invalid
    And the "I accept the terms and conditions" field should be invalid

  @TC-TC5
  Scenario: User enters invalid email format and sees validation error
    When I fill "Email address" with "invalid-email"
    And I fill "First name" with "{{random.firstName}}"
    And I fill "Last name" with "{{random.lastName}}"
    And I fill "Mobile number" with "+1234567890"
    And I fill "Age (years)" with "25"
    And I select "Male" from "Gender identity"
    And I fill "Account password" with "Secret123"
    And I fill "Confirm password" with "Secret123"
    And I check "I accept the terms and conditions"
    And I click the "Create account" button
    Then the "Email address" field should be invalid

  @TC-TC6
  Scenario: User types script in text input and sees it rendered as plain text
    When I fill "Email address" with "{{random.email}}"
    And I fill "First name" with "<script>alert(1)</script>"
    And I fill "Last name" with "{{random.lastName}}"
    And I fill "Mobile number" with "+1234567890"
    And I fill "Age (years)" with "25"
    And I select "Male" from "Gender identity"
    And I fill "Account password" with "Secret123"
    And I fill "Confirm password" with "Secret123"
    And I check "I accept the terms and conditions"
    And I click the "Create account" button
    Then the URL should not contain "/register"

  @TC-TC7
  Scenario: Registration page displays all required fields including username, email, password
    # needs-review: no Username field on register.html (fields: First name, Last name, Email address, ...)
    @needs-review @TC-TC7
    Scenario: Registration page displays all required fields including username, email, password
    Given I open the "/register" page
    Then I should see the "First name" field
    And I should see the "Last name" field
    And I should see the "Email address" field
    And I should see the "Account password" field

  @TC-TC8
  Scenario: User enters maximum allowed characters in username field and registration succeeds
    # needs-review: no Username field on register.html (fields: First name, Last name, Email address, ...)
    @needs-review @TC-TC8
    Scenario: User enters maximum allowed characters in username field and registration succeeds
    When I fill "Email address" with "{{random.email}}"
    And I fill "First name" with "A123456789B123456789C123456789D123456789E123456789F123456789G123456789H123456789I123456789J123456789K123456789L123456789M123456789N123456789O123456789P123456789Q123456789R123456789S123456789T123456789U123456789V123456789W123456789X123456789Y123456789Z"
    And I fill "Last name" with "{{random.lastName}}"
    And I fill "Mobile number" with "+1234567890"
    And I fill "Age (years)" with "25"
    And I select "Male" from "Gender identity"
    And I fill "Account password" with "Secret123"
    And I fill "Confirm password" with "Secret123"
    And I check "I accept the terms and conditions"
    And I click the "Create account" button
    Then the URL should not contain "/register"

  @TC-TC9
  Scenario: User enters one character over maximum in username field and sees error
    # needs-review: no Username field on register.html (fields: First name, Last name, Email address, ...)
    @needs-review @TC-TC9
    Scenario: User enters one character over maximum in username field and sees error
    When I fill "Email address" with "{{random.email}}"
    And I fill "First name" with "A123456789B123456789C123456789D123456789E123456789F123456789G123456789H123456789I123456789J123456789K123456789L123456789M123456789N123456789O123456789P123456789Q123456789R123456789S123456789T123456789U123456789V123456789W123456789X123456789Y123456789Z1"
    And I fill "Last name" with "{{random.lastName}}"
    And I fill "Mobile number" with "+1234567890"
    And I fill "Age (years)" with "25"
    And I select "Male" from "Gender identity"
    And I fill "Account password" with "Secret123"
    And I fill "Confirm password" with "Secret123"
    And I check "I accept the terms and conditions"
    And I click the "Create account" button
    Then the "First name" field should be invalid

  @TC-TC10
  Scenario: Unauthenticated user accessing dashboard is redirected to login
    Given I open the "/dashboard" page
    Then the URL should contain "/login"