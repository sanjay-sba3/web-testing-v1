@TS-61
Feature: User Registration

  As a new user
  I want to register for an account
  So that I can access the platform's features

  Background:
    Given I open the "http://localhost:8080/register.html" page

  @dryrun @TC-TC1
  Scenario: Successful registration with valid data
    When I fill "First name" with "{{random.firstName}}"
    And I fill "Last name" with "{{random.lastName}}"
    And I fill "Email" with "{{random.email}}"
    And I fill "Phone" with "+1 555 123 4567"
    And I fill "Age" with "30"
    And I select "Male" from "Gender"
    And I fill "Password" with "ValidPassword123!"
    And I fill "Confirm password" with "ValidPassword123!"
    And I check "I accept the terms"
    When I click the "Create account" button
    Then the URL should not contain "register.html"

  @TC-TC2
  Scenario: Verify registration page elements on load
    Then I should see the main registration form elements

  @TC-TC3
  Scenario: Attempt registration with all fields empty
    When I click the "Create account" button
    Then the "First name" field should be invalid

  @TC-TC4
  Scenario: Attempt registration with empty email field
    When I fill "First name" with "{{random.firstName}}"
    And I fill "Last name" with "{{random.lastName}}"
    And I fill "Phone" with "+1 555 123 4567"
    And I fill "Age" with "30"
    And I select "Male" from "Gender"
    And I fill "Password" with "ValidPassword123!"
    And I fill "Confirm password" with "ValidPassword123!"
    And I check "I accept the terms"
    When I click the "Create account" button
    Then the "Email" field should be invalid

  @TC-TC5
  Scenario: Attempt registration with empty password fields
    When I fill "First name" with "{{random.firstName}}"
    And I fill "Last name" with "{{random.lastName}}"
    And I fill "Email" with "{{random.email}}"
    And I fill "Phone" with "+1 555 123 4567"
    And I fill "Age" with "30"
    And I select "Male" from "Gender"
    And I check "I accept the terms"
    When I click the "Create account" button
    Then the "Password" field should be invalid

  @TC-TC6
  Scenario: Attempt registration with invalid email format
    When I fill "First name" with "{{random.firstName}}"
    And I fill "Last name" with "{{random.lastName}}"
    And I fill "Email" with "{{negative.email}}"
    And I fill "Phone" with "+1 555 123 4567"
    And I fill "Age" with "30"
    And I select "Male" from "Gender"
    And I fill "Password" with "ValidPassword123!"
    And I fill "Confirm password" with "ValidPassword123!"
    And I check "I accept the terms"
    When I click the "Create account" button
    Then the "Email" field should be invalid

  @TC-TC7
  Scenario: Attempt registration with mismatched passwords
    When I fill "First name" with "{{random.firstName}}"
    And I fill "Last name" with "{{random.lastName}}"
    And I fill "Email" with "{{random.email}}"
    And I fill "Phone" with "+1 555 123 4567"
    And I fill "Age" with "30"
    And I select "Male" from "Gender"
    And I fill "Password" with "ValidPassword123!"
    And I fill "Confirm password" with "DifferentPassword456!"
    And I check "I accept the terms"
    When I click the "Create account" button
    Then the "Confirm password" field should be invalid

  # needs-review: requirement says password >= 8 characters, page enforces minlength=6
  @needs-review @TC-TC8
  Scenario: Attempt registration with password shorter than minimum length
    When I fill "First name" with "{{random.firstName}}"
    And I fill "Last name" with "{{random.lastName}}"
    And I fill "Email" with "{{random.email}}"
    And I fill "Phone" with "+1 555 123 4567"
    And I fill "Age" with "30"
    And I select "Male" from "Gender"
    And I fill "Password" with "short"
    And I fill "Confirm password" with "short"
    And I check "I accept the terms"
    When I click the "Create account" button
    Then the "Password" field should be invalid

  # needs-review: requirement says password >= 8 characters, page enforces minlength=6
  @needs-review @TC-TC9
  Scenario: Successful registration with password of exact minimum length (8 chars)
    When I fill "First name" with "{{random.firstName}}"
    And I fill "Last name" with "{{random.lastName}}"
    And I fill "Email" with "{{random.email}}"
    And I fill "Phone" with "+1 555 123 4567"
    And I fill "Age" with "30"
    And I select "Male" from "Gender"
    And I fill "Password" with "12345678"
    And I fill "Confirm password" with "12345678"
    And I check "I accept the terms"
    When I click the "Create account" button
    Then the URL should not contain "register.html"

  @TC-TC10
  Scenario: Verify input fields handle script tags safely
    When I fill "First name" with "{{random.firstName}}"
    And I fill "Last name" with "{{random.lastName}}"
    And I fill "Email" with "{{security.comment}}"
    And I fill "Phone" with "+1 555 123 4567"
    And I fill "Age" with "30"
    And I select "Male" from "Gender"
    And I fill "Password" with "ValidPassword123!"
    And I fill "Confirm password" with "ValidPassword123!"
    And I check "I accept the terms"
    When I click the "Create account" button
    Then the "Email" field should be invalid

  @TC-TC11
  Scenario: Verify password fields mask input
    When I fill "Password" with "some-secret-text"
    And I fill "Confirm password" with "some-secret-text"
    Then the "Password" and "Confirm password" fields should be masked

  @TC-TC12
  Scenario: Verify navigation to login page from 'Login' link
    When I click the "Login" link
    Then the URL should contain "login.html"

  @TC-TC13
  Scenario: Verify keyboard navigation through form elements
    Then I can tab through the form fields in order

  @TC-TC14
  Scenario: Verify form submission using Enter key
    When I fill "First name" with "{{random.firstName}}"
    And I fill "Last name" with "{{random.lastName}}"
    And I fill "Email" with "{{random.email}}"
    And I fill "Phone" with "+1 555 123 4567"
    And I fill "Age" with "30"
    And I select "Male" from "Gender"
    And I fill "Password" with "ValidPassword123!"
    And I fill "Confirm password" with "ValidPassword123!"
    And I check "I accept the terms"
    And I press the "Enter" key
    Then the URL should not contain "register.html"