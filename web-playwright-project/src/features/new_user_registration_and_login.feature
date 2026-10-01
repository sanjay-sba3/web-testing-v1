@TS-65
Feature: New User Registration and Login

  Background:
    Given I load the test data for "new_user_registration_and_login"

  @dryrun @TC-TC1
  Scenario: Successful user registration and subsequent login
    Given I open the "http://localhost:8080/register.html" page
    When I successfully register a new user
    Then the URL should contain "login.html"
    When I login with the new user's credentials
    Then the URL should contain "/dashboard"

  @TC-TC2
  Scenario: Verify registration page UI elements
    Given I open the "http://localhost:8080/register.html" page
    Then I should see the text "Given name"
    Then I should see the text "Family name"
    Then I should see the text "Email address"
    Then I should see the text "Account password"
    Then I should see the text "Confirm password"
    Then I should see the "Create account" button

  @TC-TC3
  Scenario: Verify login page UI elements
    Given I open the "http://localhost:8080/login.html" page
    Then I should see the text "Email"
    Then I should see the text "Password"
    Then I should see the "Sign in" button

  @TC-TC4
  Scenario: Registration attempt with all fields empty
    Given I open the "http://localhost:8080/register.html" page
    When I click the "Create account" button
    Then the "Given name" field should be invalid
    Then the "Family name" field should be invalid
    Then the "Email address" field should be invalid
    Then the "Age (years)" field should be invalid
    Then the "Gender identity" field should be invalid
    Then the "Account password" field should be invalid
    Then the "I accept the terms and conditions" field should be invalid
    Then the URL should contain "register.html"

  @TC-TC5
  Scenario: Registration attempt with mismatched passwords
    Given I open the "http://localhost:8080/register.html" page
    When I fill "Given name" with "Test"
    When I fill "Family name" with "User"
    When I fill "Email address" with "{{random.email}}"
    When I fill "Age (years)" with "30"
    When I select "Male" from "Gender identity"
    When I check "I accept the terms and conditions"
    When I fill "Account password" with a value from test data "validPassword"
    When I fill "Confirm password" with a value from test data "mismatchedPassword"
    When I click the "Create account" button
    Then I should see the text "Passwords do not match"
    Then the URL should contain "register.html"

  @TC-TC6
  Scenario: Registration attempt with invalid email format
    Given I open the "http://localhost:8080/register.html" page
    When I fill "Given name" with "Test"
    When I fill "Family name" with "User"
    When I fill "Email address" with "{{negative.email}}"
    When I fill "Age (years)" with "30"
    When I select "Male" from "Gender identity"
    When I fill "Account password" with a value from test data "validPassword"
    When I fill "Confirm password" with a value from test data "validPassword"
    When I check "I accept the terms and conditions"
    When I click the "Create account" button
    Then the "Email address" field should be invalid
    Then the URL should contain "register.html"

  @TC-TC7
  Scenario: Login attempt with incorrect password
    Given I open the "http://localhost:8080/login.html" page
    When I fill "Email" with the value of env "APP_USERNAME"
    When I fill "Password" with a value from test data "incorrectPassword"
    When I click the "Sign in" button
    Then I should see the text "Invalid email or password"
    Then the URL should contain "login.html"

  @TC-TC8
  Scenario: Login attempt with an unregistered email
    Given I open the "http://localhost:8080/login.html" page
    When I fill "Email" with "{{random.email}}"
    When I fill "Password" with a value from test data "anyPassword"
    When I click the "Sign in" button
    Then I should see the text "Invalid email or password"
    Then the URL should contain "login.html"

  @TC-TC9
  Scenario: Registration attempt with an existing email
    Given I open the "http://localhost:8080/register.html" page
    When I fill "Given name" with "Test"
    When I fill "Family name" with "User"
    When I fill "Email address" with the value of env "APP_USERNAME"
    When I fill "Age (years)" with "30"
    When I select "Male" from "Gender identity"
    When I fill "Account password" with a value from test data "validPassword"
    When I fill "Confirm password" with a value from test data "validPassword"
    When I check "I accept the terms and conditions"
    When I click the "Create account" button
    Then I should see the text "An account with this email already exists"
    Then the URL should contain "register.html"

  @TC-TC10
  Scenario: Unauthenticated access to dashboard page
    Given I open the "http://localhost:8080/dashboard.html" page
    Then the URL should contain "login.html"

  @TC-TC11
  Scenario: Verify password field masking
    Given I open the "http://localhost:8080/register.html" page
    When I fill "Account password" with "some text"
    Then the "Account password" field should be masked
    Given I open the "http://localhost:8080/login.html" page
    When I fill "Password" with "some text"
    Then the "Password" field should be masked

  @TC-TC12
  Scenario: XSS payload injection in registration form
    Given I open the "http://localhost:8080/register.html" page
    When I fill "Given name" with "Test"
    When I fill "Family name" with "User"
    When I fill "Email address" with "{{security.comment}}"
    When I fill "Age (years)" with "30"
    When I select "Male" from "Gender identity"
    When I fill "Account password" with a value from test data "validPassword"
    When I fill "Confirm password" with a value from test data "validPassword"
    When I check "I accept the terms and conditions"
    When I click the "Create account" button
    Then the "Email address" field should be invalid

  @TC-TC13
  Scenario: Keyboard navigation on registration form
    Given I open the "http://localhost:8080/register.html" page
    When I press the "Tab" key
    When I press the "Tab" key
    When I press the "Tab" key
    When I press the "Tab" key
    When I press the "Tab" key
    When I press the "Tab" key
    When I press the "Tab" key
    When I press the "Tab" key
    When I press the "Tab" key
    When I press the "Tab" key
    Then the "Create account" button has focus
    When I press the "Enter" key
    Then the "Given name" field should be invalid

  @TC-TC14
  Scenario: Keyboard navigation on login form
    Given I open the "http://localhost:8080/login.html" page
    When I press the "Tab" key
    When I press the "Tab" key
    When I press the "Tab" key
    When I press the "Tab" key
    When I press the "Tab" key
    When I press the "Tab" key
    Then the "Sign in" button has focus
    When I press the "Enter" key
    Then the "Email" field should be invalid
