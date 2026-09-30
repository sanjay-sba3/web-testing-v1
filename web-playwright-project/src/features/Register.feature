@TS-60
Feature: Register Functionality

  Background:
    Given I open the "http://localhost:8080/register.html" page

  # needs-review: no "username" field on register.html (fields are "First name", "Last name")
  @needs-review @TC-TC1
  Scenario: Verify registration page elements are displayed
    Then I should see the "First name" field
    Then I should see the "Last name" field
    Then I should see the "Email" field
    Then I should see the "Password" field
    Then I should see the "Confirm password" field
    Then I should see the "Create account" button

  @dryrun @TC-TC2
  Scenario: Successful user registration with valid data
    When I fill "First name" with "{{random.firstName}}"
    When I fill "Last name" with "{{random.lastName}}"
    When I fill "Email" with "{{random.email}}"
    When I fill "Phone" with "+1 555 123 4567"
    When I fill "Age" with "25"
    When I select "Male" from "Gender"
    When I fill "Password" with "ValidPass123!"
    When I fill "Confirm password" with "ValidPass123!"
    When I check "I accept the terms"
    When I click the "Create account" button
    Then the URL should not contain "register.html"
    Then the URL should contain "login.html"

  @TC-TC3
  Scenario: Registration attempt with empty First name
    When I fill "Last name" with "{{random.lastName}}"
    When I fill "Email" with "{{random.email}}"
    When I fill "Age" with "25"
    When I select "Male" from "Gender"
    When I fill "Password" with "ValidPass123!"
    When I fill "Confirm password" with "ValidPass123!"
    When I check "I accept the terms"
    When I click the "Create account" button
    Then the "First name" field should be invalid

  @TC-TC4
  Scenario: Registration attempt with invalid email format
    When I fill "First name" with "{{random.firstName}}"
    When I fill "Last name" with "{{random.lastName}}"
    When I fill "Email" with "{{negative.email}}"
    When I fill "Age" with "25"
    When I select "Male" from "Gender"
    When I fill "Password" with "ValidPass123!"
    When I fill "Confirm password" with "ValidPass123!"
    When I check "I accept the terms"
    When I click the "Create account" button
    Then the "Email" field should be invalid

  @TC-TC5
  Scenario: Registration attempt with mismatched passwords
    When I fill "First name" with "{{random.firstName}}"
    When I fill "Last name" with "{{random.lastName}}"
    When I fill "Email" with "{{random.email}}"
    When I fill "Age" with "25"
    When I select "Male" from "Gender"
    When I fill "Password" with "ValidPassword123!"
    When I fill "Confirm password" with "DifferentPassword456!"
    When I check "I accept the terms"
    When I click the "Create account" button
    Then the "Confirm password" field should be invalid

  # needs-review: test case assumes minlength 3 for username, but page has no minlength on "First name" field.
  @needs-review @TC-TC6
  Scenario: Registration attempt with First name shorter than assumed minimum length
    When I fill "First name" with "ab"
    When I fill "Last name" with "{{random.lastName}}"
    When I fill "Email" with "{{random.email}}"
    When I fill "Age" with "25"
    When I select "Male" from "Gender"
    When I fill "Password" with "ValidPass123!"
    When I fill "Confirm password" with "ValidPass123!"
    When I check "I accept the terms"
    When I click the "Create account" button
    Then the URL should contain "register.html"

  # needs-review: test case assumes minlength 3 for username, but page has no minlength on "First name" field.
  @needs-review @TC-TC7
  Scenario: Successful registration with First name of assumed minimum length
    When I fill "First name" with "abc"
    When I fill "Last name" with "{{random.lastName}}"
    When I fill "Email" with "{{random.email}}"
    When I fill "Age" with "25"
    When I select "Male" from "Gender"
    When I fill "Password" with "ValidPass123!"
    When I fill "Confirm password" with "ValidPass123!"
    When I check "I accept the terms"
    When I click the "Create account" button
    Then the URL should not contain "register.html"

  # needs-review: requirement says password >= 8 characters, page enforces minlength=6. A 7-char password is valid on the page but should fail per TC.
  @needs-review @TC-TC8
  Scenario: Registration attempt with password shorter than required length (7 chars)
    When I fill "First name" with "{{random.firstName}}"
    When I fill "Last name" with "{{random.lastName}}"
    When I fill "Email" with "{{random.email}}"
    When I fill "Age" with "25"
    When I select "Male" from "Gender"
    When I fill "Password" with "p@ss123"
    When I fill "Confirm password" with "p@ss123"
    When I check "I accept the terms"
    When I click the "Create account" button
    # Test expects an error, but page should accept this valid password (len 7 > minlen 6).
    Then the URL should contain "register.html"

  # needs-review: requirement says password >= 8 characters, page enforces minlength=6.
  @needs-review @TC-TC9
  Scenario: Successful registration with password of required length (8 chars)
    When I fill "First name" with "{{random.firstName}}"
    When I fill "Last name" with "{{random.lastName}}"
    When I fill "Email" with "{{random.email}}"
    When I fill "Age" with "25"
    When I select "Male" from "Gender"
    When I fill "Password" with "p@ss1234"
    When I fill "Confirm password" with "p@ss1234"
    When I check "I accept the terms"
    When I click the "Create account" button
    Then the URL should not contain "register.html"

  @TC-TC10
  Scenario: Verify XSS prevention in First name field
    When I fill "First name" with "<script>alert('xss')</script>"
    When I fill "Last name" with "{{random.lastName}}"
    When I fill "Email" with "{{random.email}}"
    When I fill "Age" with "25"
    When I select "Male" from "Gender"
    When I fill "Password" with "ValidPass123!"
    When I fill "Confirm password" with "MismatchedPassword"
    When I check "I accept the terms"
    When I click the "Create account" button
    Then the URL should contain "register.html"
    Then the "First name" field should have value "<script>alert('xss')</script>"

  @TC-TC11
  Scenario: Verify password fields are masked
    Then the "Password" field should be a password field
    Then the "Confirm password" field should be a password field

  # needs-review: no "username" field on register.html. Tab order adapted to actual fields.
  @needs-review @TC-TC12
  Scenario: Verify keyboard navigation and form submission
    When I press the "Tab" key
    Then the "First name" field should be focused
    When I fill "First name" with "{{random.firstName}}"
    When I press the "Tab" key
    Then the "Last name" field should be focused
    When I fill "Last name" with "{{random.lastName}}"
    When I press the "Tab" key
    Then the "Email" field should be focused
    When I fill "Email" with "{{random.email}}"
    When I press the "Tab" key
    When I press the "Tab" key
    When I press the "Tab" key
    When I press the "Tab" key
    Then the "Password" field should be focused
    When I fill "Password" with "ValidPass123!"
    When I press the "Tab" key
    Then the "Confirm password" field should be focused
    When I fill "Confirm password" with "ValidPass123!"
    When I press the "Tab" key
    When I check "I accept the terms"
    When I press the "Tab" key
    Then the "Create account" button should be focused
    When I press the "Enter" key
    Then the URL should not contain "register.html"

  # needs-review: no "username" field on register.html. Test adapted to actual fields.
  @needs-review @TC-TC13
  Scenario: Verify input fields have associated labels for accessibility
    When I click the text label for "First name"
    Then the "First name" field should be focused
    When I click the text label for "Last name"
    Then the "Last name" field should be focused
    When I click the text label for "Email"
    Then the "Email" field should be focused
    When I click the text label for "Password"
    Then the "Password" field should be focused
    When I click the text label for "Confirm password"
    Then the "Confirm password" field should be focused

  @TC-TC14
  Scenario: Verify direct navigation to registration page
    Then the URL should contain "http://localhost:8080/register.html"
    Then I should see the text "Register"
    Then I should see the "Create account" button
