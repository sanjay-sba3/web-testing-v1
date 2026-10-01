@TS-72
Feature: New User Registration and Login

  Background:
    Given I have a browser context

  @dryrun @TC-TC1
  Scenario: Successful user registration
    Given I open the "http://localhost:3000/register" page
    When I fill "Given name" with "{{random.firstName}}"
    And I fill "Family name" with "{{random.lastName}}"
    And I fill "Email address" with "{{random.email}}"
    And I fill "Mobile number" with "+1234567890"
    And I fill "Age (years)" with "25"
    And I select "Female" from "Gender identity"
    And I fill "Account password" with "SecretPass123!"
    And I fill "Confirm password" with "SecretPass123!"
    And I check "I accept the terms and conditions"
    When I click the "Create account" button
    Then the URL should contain "/login"

  @TC-TC2
  Scenario: Verify UI elements on the registration page
    Given I open the "http://localhost:3000/register" page
    Then I should see all required elements on the registration page

  @TC-TC3
  Scenario: Registration with empty fields
    Given I open the "http://localhost:3000/register" page
    When I click the "Create account" button
    Then the "Given name" field should be invalid

  @TC-TC4
  Scenario: Registration with invalid email format
    Given I open the "http://localhost:3000/register" page
    When I fill "Given name" with "{{random.firstName}}"
    And I fill "Family name" with "{{random.lastName}}"
    And I fill "Email address" with "{{negative.email}}"
    And I fill "Age (years)" with "25"
    And I select "Female" from "Gender identity"
    And I fill "Account password" with "SecretPass123!"
    And I fill "Confirm password" with "SecretPass123!"
    And I check "I accept the terms and conditions"
    And I click the "Create account" button
    Then the "Email address" field should be invalid

  @TC-TC5
  Scenario: Registration with non-matching passwords
    Given I open the "http://localhost:3000/register" page
    When I fill "Given name" with "{{random.firstName}}"
    And I fill "Family name" with "{{random.lastName}}"
    And I fill "Email address" with "{{random.email}}"
    And I fill "Age (years)" with "25"
    And I select "Female" from "Gender identity"
    And I fill "Account password" with "ValidPassword123"
    And I fill "Confirm password" with "DifferentPassword123"
    And I check "I accept the terms and conditions"
    And I click the "Create account" button
    Then the "Confirm password" field should be invalid

  @TC-TC6
  Scenario: Registration with an existing email
    Given I register a new user
    When I attempt to register with the same email
    Then I should see the text "Account with this email already exists."

  @TC-TC7
  Scenario: Verify password masking on registration page
    Given I open the "http://localhost:3000/register" page
    When I fill "Account password" with "some-password"
    And I fill "Confirm password" with "some-password"
    Then the "Account password" field should be a password field
    And the "Confirm password" field should be a password field

  @TC-TC8
  Scenario: Registration form XSS vulnerability check
    Given I open the "http://localhost:3000/register" page
    When I fill "Email address" with "{{security.comment}}"
    When I click the "Create account" button
    Then the "Email address" field should be invalid

  @dryrun @TC-TC9
  Scenario: Successful user login
    Given I open the "http://localhost:3000/login" page
    When I fill "Email" with the value of env "APP_USERNAME"
    And I fill "Password" with the value of env "APP_PASSWORD"
    And I click the "Sign in" button
    Then the URL should contain "/dashboard"

  @TC-TC10
  Scenario: Verify UI elements on the login page
    Given I open the "http://localhost:3000/login" page
    Then I should see all required elements on the login page

  @TC-TC11
  Scenario: Login with empty email field
    Given I open the "http://localhost:3000/login" page
    When I fill "Password" with the value of env "APP_PASSWORD"
    And I click the "Sign in" button
    Then the "Email" field should be invalid

  @TC-TC12
  Scenario: Login with empty password field
    Given I open the "http://localhost:3000/login" page
    When I fill "Email" with the value of env "APP_USERNAME"
    And I click the "Sign in" button
    Then the "Password" field should be invalid

  @TC-TC13
  Scenario: Login with incorrect password
    Given I open the "http://localhost:3000/login" page
    When I fill "Email" with the value of env "APP_USERNAME"
    And I fill "Password" with "ThisIsTheWrongPassword"
    And I click the "Sign in" button
    Then I should see the text "Invalid credentials"

  @TC-TC14
  Scenario: Login with an unregistered email
    Given I open the "http://localhost:3000/login" page
    When I fill "Email" with "{{random.email}}"
    And I fill "Password" with "any-password"
    And I click the "Sign in" button
    Then I should see the text "Invalid credentials"

  @TC-TC15
  Scenario: Verify password masking on login page
    Given I open the "http://localhost:3000/login" page
    When I fill "Password" with "some-password"
    Then the "Password" field should be a password field

  @TC-TC16
  Scenario: Login form XSS vulnerability check
    Given I open the "http://localhost:3000/login" page
    When I fill "Email" with "{{security.comment}}"
    And I fill "Password" with "{{random.password}}"
    And I click the "Sign in" button
    Then the "Email" field should be invalid

  @TC-TC17
  Scenario: Direct navigation to registration page
    Given I open the "http://localhost:3000/register" page
    Then the page title should contain "DemoApp"
    And I should see the "Create account" button

  @TC-TC18
  Scenario: Direct navigation to login page
    Given I open the "http://localhost:3000/login" page
    Then the page title should contain "DemoApp"
    And I should see the "Sign in" button

  @TC-TC19
  Scenario: Unauthorized access to dashboard page
    Given I open the "http://localhost:3000/dashboard" page
    Then the URL should contain "/login"
