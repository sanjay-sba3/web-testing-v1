@TS-61
Feature: Register
  This feature covers user registration functionality, including successful registration, validation of input fields, and security checks.

  Background:
    Given I open the "http://localhost:8080/register.html" page

  @dryrun @TC-TC1
  Scenario: Successful registration with valid data
    When I fill "Given name" with "{{random.firstName}}"
    And I fill "Family name" with "{{random.lastName}}"
    And I fill "Email address" with "{{random.email}}"
    And I fill "Mobile number" with "+1 555 123 4567"
    And I fill "Age (years)" with "30"
    And I select "Male" from "Gender identity"
    And I fill "Account password" with "ValidPassword123!"
    And I fill "Confirm password" with "ValidPassword123!"
    And I check "I accept the terms and conditions"
    And I click the "Create account" button
    Then the URL should not contain "register.html"

  @TC-TC2
  Scenario: Verify registration page elements on load
    Then the page title should contain "Register"
    And I should see the following elements:
      | Element Name       |
      | Given name         |
      | Family name        |
      | Email address      |
      | Account password   |
      | Confirm password   |
      | Create account     |

  @TC-TC3
  Scenario: Attempt registration with all fields empty
    When I click the "Create account" button
    Then the "Given name" field should be invalid
    And the "Family name" field should be invalid
    And the "Email address" field should be invalid
    And the "Age (years)" field should be invalid
    And the "Gender identity" field should be invalid
    And the "Account password" field should be invalid
    And the "I accept the terms and conditions" field should be invalid

  @TC-TC4
  Scenario: Attempt registration with empty email field
    When I fill "Given name" with "Test"
    And I fill "Family name" with "User"
    And I fill "Age (years)" with "25"
    And I select "Female" from "Gender identity"
    And I fill "Account password" with "ValidPassword123!"
    And I fill "Confirm password" with "ValidPassword123!"
    And I check "I accept the terms and conditions"
    And I click the "Create account" button
    Then the "Email address" field should be invalid

  @TC-TC5
  Scenario: Attempt registration with empty password fields
    When I fill "Given name" with "Test"
    And I fill "Family name" with "User"
    And I fill "Email address" with "{{random.email}}"
    And I fill "Age (years)" with "25"
    And I select "Other" from "Gender identity"
    And I check "I accept the terms and conditions"
    And I click the "Create account" button
    Then the "Account password" field should be invalid

  @TC-TC6
  Scenario: Attempt registration with invalid email format
    When I fill "Given name" with "Test"
    And I fill "Family name" with "User"
    And I fill "Email address" with "{{negative.email}}"
    And I fill "Age (years)" with "25"
    And I select "Female" from "Gender identity"
    And I fill "Account password" with "ValidPassword123!"
    And I fill "Confirm password" with "ValidPassword123!"
    And I check "I accept the terms and conditions"
    And I click the "Create account" button
    Then the "Email address" field should be invalid

  @TC-TC7
  Scenario: Attempt registration with mismatched passwords
    When I fill "Given name" with "Test"
    And I fill "Family name" with "User"
    And I fill "Email address" with "{{random.email}}"
    And I fill "Age (years)" with "25"
    And I select "Prefer not to say" from "Gender identity"
    And I fill "Account password" with "ValidPassword123!"
    And I fill "Confirm password" with "DifferentPassword456!"
    And I check "I accept the terms and conditions"
    And I click the "Create account" button
    Then the "Confirm password" field should be invalid

  # needs-review: requirement says password >= 8 characters, page enforces minlength=6
  @needs-review @TC-TC8
  Scenario: Attempt registration with password shorter than minimum length
    When I fill "Given name" with "Test"
    And I fill "Family name" with "User"
    And I fill "Email address" with "{{random.email}}"
    And I fill "Age (years)" with "25"
    And I select "Male" from "Gender identity"
    And I fill "Account password" with "short"
    And I fill "Confirm password" with "short"
    And I check "I accept the terms and conditions"
    And I click the "Create account" button
    Then the "Account password" field should be invalid

  # needs-review: requirement says password >= 8 characters, page enforces minlength=6
  @needs-review @TC-TC9
  Scenario: Successful registration with password of exact minimum length
    When I fill "Given name" with "Test"
    And I fill "Family name" with "User"
    And I fill "Email address" with "{{random.email}}"
    And I fill "Age (years)" with "25"
    And I select "Female" from "Gender identity"
    And I fill "Account password" with "12345678"
    And I fill "Confirm password" with "12345678"
    And I check "I accept the terms and conditions"
    And I click the "Create account" button
    Then the URL should not contain "register.html"

  @TC-TC10
  Scenario: Verify input fields handle script tags safely
    When I fill "Given name" with "Test"
    And I fill "Family name" with "User"
    And I fill "Email address" with "{{security.comment}}"
    And I fill "Age (years)" with "25"
    And I select "Male" from "Gender identity"
    And I fill "Account password" with "ValidPassword123!"
    And I fill "Confirm password" with "ValidPassword123!"
    And I check "I accept the terms and conditions"
    And I click the "Create account" button
    Then the "Email address" field should be invalid

  @TC-TC11
  Scenario: Verify password fields mask input
    Then the "Account password" element should be a password field
    And the "Confirm password" element should be a password field

  @TC-TC12
  Scenario: Verify navigation to login page from 'Login' link
    When I click the "Login" link
    Then the URL should contain "login.html"

  @TC-TC13
  Scenario: Verify keyboard navigation through form elements
    When I press the "Tab" key
    Then the element with accessible name "Given name" should be focused
    When I press the "Tab" key
    Then the element with accessible name "Family name" should be focused
    When I press the "Tab" key
    Then the element with accessible name "Email address" should be focused
    When I press the "Tab" key
    Then the element with accessible name "Mobile number" should be focused
    When I press the "Tab" key
    Then the element with accessible name "Age (years)" should be focused
    When I press the "Tab" key
    Then the element with accessible name "Gender identity" should be focused
    When I press the "Tab" key
    Then the element with accessible name "Account password" should be focused
    When I press the "Tab" key
    Then the element with accessible name "Confirm password" should be focused
    When I press the "Tab" key
    Then the element with accessible name "I accept the terms and conditions" should be focused
    When I press the "Tab" key
    Then the element with accessible name "Create account" should be focused

  @TC-TC14
  Scenario: Verify form submission using Enter key
    When I fill "Given name" with "{{random.firstName}}"
    And I fill "Family name" with "{{random.lastName}}"
    And I fill "Email address" with "{{random.email}}"
    And I fill "Age (years)" with "40"
    And I select "Other" from "Gender identity"
    And I fill "Account password" with "ValidPassword123!"
    And I fill "Confirm password" with "ValidPassword123!"
    And I check "I accept the terms and conditions"
    And I press the "Enter" key
    Then the URL should not contain "register.html"
