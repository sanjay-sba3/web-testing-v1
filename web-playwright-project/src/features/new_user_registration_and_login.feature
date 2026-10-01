@TS-65
Feature: New User Registration and Login

  As a user
  I want to be able to register a new account and log in
  So that I can access protected content

  Background:
    Given I open the "http://localhost:8080/login.html" page

  @dryrun @TC-TC1
  Scenario: Successful user registration and subsequent login
    Given I open the "http://localhost:8080/register.html" page
    When I fill "Given name" with "Test"
    And I fill "Family name" with "User"
    And I fill "Email address" with test data "newUserEmail"
    And I fill "Mobile number" with "+1 555 123 4567"
    And I fill "Age (years)" with "30"
    And I select "Male" from "Gender identity"
    And I fill "Account password" with test data "newUserPassword"
    And I fill "Confirm password" with test data "newUserPassword"
    And I check "I accept the terms and conditions"
    And I click the "Create account" button
    Then the URL should contain "login.html"
    When I fill "Email" with test data "newUserEmail"
    And I fill "Password" with test data "newUserPassword"
    And I click the "Sign in" button
    Then the URL should contain "/dashboard"

  @TC-TC2
  Scenario: Verify registration page UI elements
    Given I open the "http://localhost:8080/register.html" page
    Then the "Email address" field should be visible
    And the "Account password" field should be visible
    And the "Confirm password" field should be visible
    And I should see the "Create account" button

  @TC-TC3
  Scenario: Verify login page UI elements
    Given I open the "http://localhost:8080/login.html" page
    Then the "Email" field should be visible
    And the "Password" field should be visible
    And I should see the "Sign in" button

  @TC-TC4
  Scenario: Registration attempt with all fields empty
    Given I open the "http://localhost:8080/register.html" page
    When I click the "Create account" button
    Then the "Given name" field should be invalid
    And the "Family name" field should be invalid
    And the "Email address" field should be invalid
    And the "Age (years)" field should be invalid
    And the "Account password" field should be invalid
    And the "Confirm password" field should be invalid
    And the "I accept the terms and conditions" field should be invalid
    And the URL should contain "register.html"

  @TC-TC5
  Scenario: Registration attempt with mismatched passwords
    Given I open the "http://localhost:8080/register.html" page
    When I fill "Given name" with "Test"
    And I fill "Family name" with "User"
    And I fill "Email address" with test data "newUserEmail"
    And I fill "Age (years)" with "30"
    And I select "Male" from "Gender identity"
    And I fill "Account password" with test data "newUserPassword"
    And I fill "Confirm password" with test data "mismatchedPassword"
    And I check "I accept the terms and conditions"
    And I click the "Create account" button
    Then I should see the text "Passwords do not match"
    And the URL should contain "register.html"

  @TC-TC6
  Scenario: Registration attempt with invalid email format
    Given I open the "http://localhost:8080/register.html" page
    When I fill "Given name" with "Test"
    And I fill "Family name" with "User"
    And I fill "Email address" with test data "invalidEmail"
    And I fill "Age (years)" with "30"
    And I select "Male" from "Gender identity"
    And I fill "Account password" with test data "newUserPassword"
    And I fill "Confirm password" with test data "newUserPassword"
    And I check "I accept the terms and conditions"
    And I click the "Create account" button
    Then the "Email address" field should be invalid
    And the URL should contain "register.html"

  @TC-TC7
  Scenario: Login attempt with incorrect password
    Given I open the "http://localhost:8080/login.html" page
    When I fill "Email" with the value of env "APP_USERNAME"
    And I fill "Password" with test data "incorrectPassword"
    And I click the "Sign in" button
    Then I should see the text "Invalid email or password"
    And the URL should contain "login.html"

  @TC-TC8
  Scenario: Login attempt with an unregistered email
    Given I open the "http://localhost:8080/login.html" page
    When I fill "Email" with test data "unregisteredEmail"
    And I fill "Password" with test data "anyPassword"
    And I click the "Sign in" button
    Then I should see the text "Invalid email or password"
    And the URL should contain "login.html"

  @TC-TC9
  Scenario: Registration attempt with an existing email
    Given I open the "http://localhost:8080/register.html" page
    When I fill "Given name" with "Test"
    And I fill "Family name" with "User"
    And I fill "Email address" with the value of env "APP_USERNAME"
    And I fill "Age (years)" with "30"
    And I select "Male" from "Gender identity"
    And I fill "Account password" with test data "newUserPassword"
    And I fill "Confirm password" with test data "newUserPassword"
    And I check "I accept the terms and conditions"
    And I click the "Create account" button
    Then I should see the text "An account with this email already exists"
    And the URL should contain "register.html"

  @TC-TC10
  Scenario: Unauthenticated access to dashboard page
    Given I open the "http://localhost:8080/dashboard.html" page
    Then the URL should contain "login.html"

  @TC-TC11
  Scenario: Verify password field masking
    Given I open the "http://localhost:8080/register.html" page
    When I fill "Account password" with "some text"
    Then the "Account password" field is masked
    Given I open the "http://localhost:8080/login.html" page
    When I fill "Password" with "some text"
    Then the "Password" field is masked

  @TC-TC12
  Scenario: XSS payload injection in registration form
    Given I open the "http://localhost:8080/register.html" page
    When I fill "Given name" with "Test"
    And I fill "Family name" with "User"
    And I fill "Email address" with test data "xssPayload"
    And I fill "Age (years)" with "30"
    And I select "Male" from "Gender identity"
    And I fill "Account password" with test data "newUserPassword"
    And I fill "Confirm password" with test data "newUserPassword"
    And I check "I accept the terms and conditions"
    And I click the "Create account" button
    Then the "Email address" field should be invalid

  # needs-review: This scenario tests the actual tab order from the DOM, which is more comprehensive than the original test case.
  @needs-review @TC-TC13
  Scenario: Keyboard navigation on registration form
    Given I open the "http://localhost:8080/register.html" page
    When I press the "Tab" key
    Then the "Given name" field has focus
    When I press the "Tab" key
    Then the "Family name" field has focus
    When I press the "Tab" key
    Then the "Email address" field has focus
    When I press the "Tab" key
    Then the "Mobile number" field has focus
    When I press the "Tab" key
    Then the "Age (years)" field has focus
    When I press the "Tab" key
    Then the "Gender identity" field has focus
    When I press the "Tab" key
    Then the "Account password" field has focus
    When I press the "Tab" key
    Then the "Confirm password" field has focus
    When I press the "Tab" key
    Then the "I accept the terms and conditions" checkbox has focus
    When I press the "Tab" key
    Then the "Create account" button has focus
    When I press the "Enter" key
    Then the "Given name" field should be invalid

  # needs-review: This scenario tests the actual tab order from the DOM, which is more comprehensive than the original test case.
  @needs-review @TC-TC14
  Scenario: Keyboard navigation on login form
    Given I open the "http://localhost:8080/login.html" page
    When I press the "Tab" key
    Then the "Email" field has focus
    When I press the "Tab" key
    Then the "Password" field has focus
    When I press the "Tab" key
    Then the "Show" button has focus
    When I press the "Tab" key
    Then the "Remember my email" checkbox has focus
    When I press the "Tab" key
    Then the "Create account" link has focus
    When I press the "Tab" key
    Then the "Sign in" button has focus
    When I press the "Enter" key
    Then the "Email" field should be invalid
