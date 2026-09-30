@TS-59
Feature: User Registration

  Background:
    Given I open the "http://localhost:8080/register.html" page

  @TC-TC1
  Scenario: Verify registration page elements are visible
    Then the "First name" field should be visible
    And the "Last name" field should be visible
    And the "Email" field should be visible
    And the "Password" field should be visible
    And the "Confirm password" field should be visible
    And I should see the "Create account" button

  @dryrun @TC-TC2
  Scenario: Successful user registration with valid data
    When I fill "First name" with "John"
    And I fill "Last name" with "Doe"
    And I fill "Email" with "{{random.email}}"
    And I fill "Phone" with "+1 555 123 4567"
    And I fill "Age" with "30"
    And I select "Male" from "Gender"
    And I fill "Password" with "ValidP@ssw0rd123"
    And I fill "Confirm password" with "ValidP@ssw0rd123"
    And I check "I accept the terms"
    And I click the "Create account" button
    Then the URL should not contain "register.html"

  @TC-TC3
  Scenario: Verify required field validation on empty form submission
    When I click the "Create account" button
    Then the "First name" field should be invalid
    And the "Last name" field should be invalid
    And the "Email" field should be invalid
    And the "Age" field should be invalid
    And the "Gender" field should be invalid
    And the "Password" field should be invalid
    And the "Confirm password" field should be invalid
    And the "I accept the terms" field should be invalid

  @TC-TC4
  Scenario: Verify email field validation for invalid format
    When I fill "First name" with "John"
    And I fill "Last name" with "Doe"
    And I fill "Email" with "{{negative.email}}"
    And I fill "Phone" with "+1 555 123 4567"
    And I fill "Age" with "30"
    And I select "Male" from "Gender"
    And I fill "Password" with "ValidP@ssw0rd123"
    And I fill "Confirm password" with "ValidP@ssw0rd123"
    And I check "I accept the terms"
    And I click the "Create account" button
    Then the "Email" field should be invalid
    And the URL should contain "register.html"

  @TC-TC5
  Scenario: Verify password confirmation mismatch validation
    When I fill "First name" with "John"
    And I fill "Last name" with "Doe"
    And I fill "Email" with "{{random.email}}"
    And I fill "Phone" with "+1 555 123 4567"
    And I fill "Age" with "30"
    And I select "Male" from "Gender"
    And I fill "Password" with "ValidP@ssw0rd123"
    And I fill "Confirm password" with "DifferentP@ssw0rd456"
    And I check "I accept the terms"
    And I click the "Create account" button
    Then the "Confirm password" field should be invalid
    And the URL should contain "register.html"

  @TC-TC6
  Scenario: Verify password fields are masked
    When I fill "Password" with "MySecretPassword"
    Then the "Password" field should be a password field
    When I fill "Confirm password" with "MySecretPassword"
    Then the "Confirm password" field should be a password field

  @TC-TC7
  Scenario: Verify XSS protection on text input fields
    When I fill "First name" with "{{security.comment}}"
    And I fill "Last name" with "Doe"
    And I fill "Email" with "{{random.email}}"
    And I fill "Phone" with "+1 555 123 4567"
    And I fill "Age" with "30"
    And I select "Male" from "Gender"
    And I fill "Password" with "ValidP@ssw0rd123"
    And I fill "Confirm password" with "ValidP@ssw0rd123"
    And I check "I accept the terms"
    And I click the "Create account" button
    Then the URL should not contain "register.html"

  @TC-TC8
  Scenario: Verify keyboard navigation and submission
    When I fill "First name" with "Jane"
    And I press the "Tab" key
    When I fill "Last name" with "Smith"
    And I press the "Tab" key
    When I fill "Email" with "{{random.email}}"
    And I press the "Tab" key
    When I fill "Phone" with "+1 555 123 4567"
    And I press the "Tab" key
    When I fill "Age" with "25"
    And I press the "Tab" key
    When I select "Female" from "Gender"
    And I press the "Tab" key
    When I fill "Password" with "ValidP@ssw0rd123"
    And I press the "Tab" key
    When I fill "Confirm password" with "ValidP@ssw0rd123"
    And I press the "Tab" key
    When I check "I accept the terms"
    And I press the "Tab" key
    And I press the "Enter" key
    Then the URL should not contain "register.html"

  @TC-TC9
  Scenario: Verify all input fields have visible labels
    Then I should see the text "First name"
    And I should see the text "Last name"
    And I should see the text "Email"
    And I should see the text "Password"
    And I should see the text "Confirm password"
    And I should see the text "Phone"
    And I should see the text "Age"
    And I should see the text "Gender"
    And I should see the text "I accept the terms"

  @TC-TC10
  Scenario: Verify direct navigation to registration page
    Then the page title should contain "Register"
