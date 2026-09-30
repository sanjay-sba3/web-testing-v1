@TS-57
Feature: Register
  As a new user, I want to create an account so that I can access the application.

  Background:
    Given I open the "http://localhost:8080/register.html" page

  @TC-TC1
  Scenario: Verify visibility of registration form elements
    Then the "First name" field should be visible
    And the "Last name" field should be visible
    And the "Email" field should be visible
    And the "Password" field should be visible
    And the "Confirm password" field should be visible
    And I should see the "Create account" button

  @TC-TC2
  Scenario: Verify visibility of the login link
    Then I should see the "Login" link

  @TC-TC3
  Scenario: Verify all input fields have visible labels
    Then I should see the text "First name"
    And I should see the text "Last name"
    And I should see the text "Email"
    And I should see the text "Password"
    And I should see the text "Confirm password"

  @dryrun @TC-TC4
  Scenario: Successful registration with valid data
    When I fill "First name" with "{{random.firstName}}"
    And I fill "Last name" with "{{random.lastName}}"
    And I fill "Email" with "{{random.email}}"
    And I fill "Password" with test data "validPassword"
    And I fill "Confirm password" with test data "validPassword"
    And I check "I accept the terms"
    When I click the "Create account" button
    Then the URL should contain "login.html"
    And I should see the text "Registration successful. Please log in."

  @TC-TC5
  Scenario: Attempt registration with all fields empty
    When I click the "Create account" button
    Then the "First name" field should be invalid
    And the "Last name" field should be invalid
    And the "Email" field should be invalid
    And the "Password" field should be invalid
    And the "Confirm password" field should be invalid
    And the "I accept the terms" checkbox should be invalid

  @TC-TC6
  Scenario: Attempt registration with an invalid email format
    When I fill "First name" with "John"
    And I fill "Last name" with "Doe"
    And I fill "Email" with "{{negative.email}}"
    And I fill "Password" with test data "validPassword"
    And I fill "Confirm password" with test data "validPassword"
    And I check "I accept the terms"
    When I click the "Create account" button
    Then the "Email" field should be invalid

  @TC-TC7
  Scenario: Attempt registration with mismatched passwords
    When I fill "First name" with "Jane"
    And I fill "Last name" with "Doe"
    And I fill "Email" with "{{random.email}}"
    And I fill "Password" with test data "passwordA"
    And I fill "Confirm password" with test data "passwordB"
    And I check "I accept the terms"
    When I click the "Create account" button
    Then I should see the text "passwords do not match"

  @TC-TC8
  Scenario: Attempt registration with an existing email
    When I fill "First name" with "Existing"
    And I fill "Last name" with "User"
    And I fill "Email" with test data "existingEmail"
    And I fill "Password" with test data "validPassword"
    And I fill "Confirm password" with test data "validPassword"
    And I check "I accept the terms"
    When I click the "Create account" button
    Then I should see the text "email address is already taken"

  @TC-TC9
  Scenario: Navigate to login page from registration page
    When I click the "Login" link
    Then the URL should contain "login.html"

  # needs-review: no mechanism specified to satisfy precondition "User is already logged in"
  @needs-review @TC-TC10
  Scenario: Authenticated user is redirected from registration page
    Then the URL should contain "/dashboard"

  @TC-TC11
  Scenario: Verify password fields are masked
    When I fill "Password" with test data "anyPassword"
    Then the "Password" field should be masked
    When I fill "Confirm password" with test data "anyPassword"
    Then the "Confirm password" field should be masked

  @TC-TC12
  Scenario: Verify script injection is sanitized in text fields
    When I fill "First name" with a security script and save it as "firstNameScript"
    And I fill "Last name" with a security script and save it as "lastNameScript"
    And I fill "Email" with "{{random.email}}"
    And I check "I accept the terms"
    When I click the "Create account" button
    Then the "Password" field should be invalid
    And the "First name" field should have the value of context variable "firstNameScript"
    And the "Last name" field should have the value of context variable "lastNameScript"

  @TC-TC13
  Scenario: Verify logical tab navigation through form elements
    When I press the "Tab" key
    Then the focus should be on the "First name" field
    When I press the "Tab" key
    Then the focus should be on the "Last name" field
    When I press the "Tab" key
    Then the focus should be on the "Email" field
    When I press the "Tab" key
    Then the focus should be on the "Phone" field
    When I press the "Tab" key
    Then the focus should be on the "Age" spinbutton
    When I press the "Tab" key
    Then the focus should be on the "Gender" combobox
    When I press the "Tab" key
    Then the focus should be on the "Password" field
    When I press the "Tab" key
    Then the focus should be on the "Confirm password" field
    When I press the "Tab" key
    Then the focus should be on the "I accept the terms" checkbox
    When I press the "Tab" key
    Then the focus should be on the "Create account" button
    When I press the "Tab" key
    Then the focus should be on the "Login" link

  @TC-TC14
  Scenario: Verify form submission via Enter key
    When I fill "First name" with "{{random.firstName}}"
    And I fill "Last name" with "{{random.lastName}}"
    And I fill "Email" with "{{random.email}}"
    And I fill "Password" with test data "validPassword"
    And I fill "Confirm password" with test data "validPassword"
    And I check "I accept the terms"
    When I press the "Enter" key
    Then the URL should contain "login.html"
    And I should see the text "Registration successful. Please log in."
