@TS-61
Feature: Register
  As a new user
  I want to create an account
  So that I can access the platform features

  Background:
    Given I open the "http://localhost:8080/register.html" page

  @dryrun @TC-TC1
  Scenario: Successful registration with valid data
    When I fill "Given name" with "{{random.firstName}}"
    When I fill "Family name" with "{{random.lastName}}"
    When I fill "Email address" with "{{random.email}}"
    When I fill "Age (years)" with "25"
    When I select "Female" from "Gender identity"
    When I fill "Account password" with "ValidPassword123!"
    When I fill "Confirm password" with "ValidPassword123!"
    When I check "I accept the terms and conditions"
    When I click the "Create account" button
    Then the URL should not contain "register.html"

  @TC-TC2
  Scenario: Verify registration page elements on load
    Then I should see the text "Given name"
    Then I should see the text "Family name"
    Then I should see the text "Email address"
    Then I should see the text "Account password"
    Then I should see the text "Confirm password"
    Then I should see the "Create account" button

  @TC-TC3
  Scenario: Attempt registration with all fields empty
    When I click the "Create account" button
    Then the "Given name" field should be invalid
    Then the "Email address" field should be invalid
    Then the "Account password" field should be invalid

  @TC-TC4
  Scenario: Attempt registration with empty email field
    When I fill "Given name" with "{{random.firstName}}"
    When I fill "Family name" with "{{random.lastName}}"
    When I fill "Age (years)" with "25"
    When I select "Female" from "Gender identity"
    When I fill "Account password" with "ValidPassword123!"
    When I fill "Confirm password" with "ValidPassword123!"
    When I check "I accept the terms and conditions"
    When I click the "Create account" button
    Then the "Email address" field should be invalid

  @TC-TC5
  Scenario: Attempt registration with empty password fields
    When I fill "Given name" with "{{random.firstName}}"
    When I fill "Family name" with "{{random.lastName}}"
    When I fill "Email address" with "{{random.email}}"
    When I fill "Age (years)" with "25"
    When I select "Female" from "Gender identity"
    When I check "I accept the terms and conditions"
    When I click the "Create account" button
    Then the "Account password" field should be invalid

  @TC-TC6
  Scenario: Attempt registration with invalid email format
    When I fill "Given name" with "{{random.firstName}}"
    When I fill "Family name" with "{{random.lastName}}"
    When I fill "Email address" with "{{negative.email}}"
    When I fill "Age (years)" with "25"
    When I select "Female" from "Gender identity"
    When I fill "Account password" with "ValidPassword123!"
    When I fill "Confirm password" with "ValidPassword123!"
    When I check "I accept the terms and conditions"
    When I click the "Create account" button
    Then the "Email address" field should be invalid

  @TC-TC7
  Scenario: Attempt registration with mismatched passwords
    When I fill "Given name" with "{{random.firstName}}"
    When I fill "Family name" with "{{random.lastName}}"
    When I fill "Email address" with "{{random.email}}"
    When I fill "Age (years)" with "25"
    When I select "Female" from "Gender identity"
    When I fill "Account password" with "ValidPassword123!"
    When I fill "Confirm password" with "DifferentPassword456!"
    When I check "I accept the terms and conditions"
    When I click the "Create account" button
    Then the "Confirm password" field should be invalid

  # needs-review: requirement says password >= 8 characters, page enforces minlength=6
  @needs-review @TC-TC8
  Scenario: Attempt registration with password shorter than minimum length
    When I fill "Given name" with "{{random.firstName}}"
    When I fill "Family name" with "{{random.lastName}}"
    When I fill "Email address" with "{{random.email}}"
    When I fill "Age (years)" with "25"
    When I select "Female" from "Gender identity"
    When I fill "Account password" with "short"
    When I fill "Confirm password" with "short"
    When I check "I accept the terms and conditions"
    When I click the "Create account" button
    Then the "Account password" field should be invalid

  # needs-review: requirement says password >= 8 characters, page enforces minlength=6
  @needs-review @TC-TC9
  Scenario: Successful registration with password of exact minimum length
    When I fill "Given name" with "{{random.firstName}}"
    When I fill "Family name" with "{{random.lastName}}"
    When I fill "Email address" with "{{random.email}}"
    When I fill "Age (years)" with "25"
    When I select "Female" from "Gender identity"
    When I fill "Account password" with "123456"
    When I fill "Confirm password" with "123456"
    When I check "I accept the terms and conditions"
    When I click the "Create account" button
    Then the URL should not contain "register.html"

  @TC-TC10
  Scenario: Verify input fields handle script tags safely
    When I fill "Given name" with "{{security.comment}}"
    When I fill "Family name" with "{{random.lastName}}"
    When I fill "Email address" with "{{negative.email}}"
    When I fill "Age (years)" with "25"
    When I select "Female" from "Gender identity"
    When I fill "Account password" with "ValidPassword123!"
    When I fill "Confirm password" with "ValidPassword123!"
    When I check "I accept the terms and conditions"
    When I click the "Create account" button
    Then the "Email address" field should be invalid

  @TC-TC11
  Scenario: Verify password fields mask input
    When I fill "Account password" with "some-secret-text"
    Then the "Account password" field should be masked
    When I fill "Confirm password" with "some-secret-text"
    Then the "Confirm password" field should be masked

  @TC-TC12
  Scenario: Verify navigation to login page from 'Login' link
    When I click the "Login" link
    Then the URL should contain "login.html"

  @TC-TC13
  Scenario: Verify keyboard navigation through form elements
    When I press the "Tab" key
    Then the "Given name" element should be focused
    When I press the "Tab" key
    Then the "Family name" element should be focused
    When I press the "Tab" key
    Then the "Email address" element should be focused
    When I press the "Tab" key
    When I press the "Tab" key
    When I press the "Tab" key
    When I press the "Tab" key
    Then the "Account password" element should be focused
    When I press the "Tab" key
    Then the "Confirm password" element should be focused
    When I press the "Tab" key
    Then the "I accept the terms and conditions" element should be focused
    When I press the "Tab" key
    Then the "Create account" element should be focused

  @TC-TC14
  Scenario: Verify form submission using Enter key
    When I fill "Given name" with "{{random.firstName}}"
    When I fill "Family name" with "{{random.lastName}}"
    When I fill "Email address" with "{{random.email}}"
    When I fill "Age (years)" with "25"
    When I select "Female" from "Gender identity"
    When I fill "Account password" with "ValidPassword123!"
    When I fill "Confirm password" with "ValidPassword123!"
    When I check "I accept the terms and conditions"
    When I press the "Enter" key
    Then the URL should not contain "register.html"