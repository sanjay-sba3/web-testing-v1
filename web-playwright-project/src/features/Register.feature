@TS-61
Feature: User Registration

  As a new user
  I want to create an account
  So that I can access personalized features

  Background:
    Given I open the "http://localhost:8080/register.html" page

  @dryrun @TC-TC1
  Scenario: Successful registration with valid data
    When I fill "First name" with "John"
    And I fill "Last name" with "Doe"
    And I fill "Email" with "{{random.email}}"
    And I fill "Phone" with "+1 555 555 5123"
    And I fill "Age" with "30"
    And I select "Male" from "Gender"
    And I fill "Password" with "ValidPassword123!"
    And I fill "Confirm password" with "ValidPassword123!"
    And I check "I accept the terms"
    And I click the "Create account" button
    Then the URL should not contain "register.html"

  @TC-TC2
  Scenario: Verify registration page elements on load
    Then the page title should contain "Register"
    And I should see the text "First name"
    And I should see the text "Last name"
    And I should see the text "Email"
    And I should see the text "Phone"
    And I should see the text "Age"
    And I should see the text "Gender"
    And I should see the text "Password"
    And I should see the text "Confirm password"
    And I should see the text "I accept the terms"
    And I should see the "Create account" button
    And I should see the "Login" link

  @TC-TC3
  Scenario: Attempt registration with all fields empty
    When I click the "Create account" button
    Then the "First name" field should be invalid
    And the "Last name" field should be invalid
    And the "Email" field should be invalid
    And the "Age" field should be invalid
    And the "Password" field should be invalid
    # needs-review: Checkbox and Select validation via '...field should be invalid' might depend on specific shared step implementation
    And the "Gender" field should be invalid
    And the "I accept the terms" field should be invalid

  @TC-TC4
  Scenario: Attempt registration with empty email field
    When I fill "First name" with "Test"
    And I fill "Last name" with "User"
    And I fill "Age" with "25"
    And I select "Female" from "Gender"
    And I fill "Password" with "ValidPassword123!"
    And I fill "Confirm password" with "ValidPassword123!"
    And I check "I accept the terms"
    And I click the "Create account" button
    Then the "Email" field should be invalid

  @TC-TC5
  Scenario: Attempt registration with empty password fields
    When I fill "First name" with "Test"
    And I fill "Last name" with "User"
    And I fill "Email" with "{{random.email}}"
    And I fill "Age" with "25"
    And I select "Female" from "Gender"
    And I check "I accept the terms"
    And I click the "Create account" button
    Then the "Password" field should be invalid

  @TC-TC6
  Scenario: Attempt registration with invalid email format
    When I fill "First name" with "Test"
    And I fill "Last name" with "User"
    And I fill "Email" with "{{negative.email}}"
    And I fill "Age" with "25"
    And I select "Female" from "Gender"
    And I fill "Password" with "ValidPassword123!"
    And I fill "Confirm password" with "ValidPassword123!"
    And I check "I accept the terms"
    And I click the "Create account" button
    Then the "Email" field should be invalid

  @TC-TC7
  Scenario: Attempt registration with mismatched passwords
    When I fill "First name" with "Test"
    And I fill "Last name" with "User"
    And I fill "Email" with "{{random.email}}"
    And I fill "Age" with "25"
    And I select "Other" from "Gender"
    And I fill "Password" with "ValidPassword123!"
    And I fill "Confirm password" with "DifferentPassword456!"
    And I check "I accept the terms"
    And I click the "Create account" button
    Then the "Confirm password" field should be invalid

  # needs-review: requirement in TC8 says minimum password length is 8, but the page's form validation enforces minlength=6.
  @needs-review @TC-TC8
  Scenario: Attempt registration with password shorter than minimum length
    When I fill "First name" with "Test"
    And I fill "Last name" with "User"
    And I fill "Email" with "{{random.email}}"
    And I fill "Age" with "25"
    And I select "Other" from "Gender"
    And I fill "Password" with "short"
    And I fill "Confirm password" with "short"
    And I check "I accept the terms"
    And I click the "Create account" button
    Then the "Password" field should be invalid

  # needs-review: requirement in TC9 says minimum password length is 8, but the page's form validation enforces minlength=6.
  @needs-review @TC-TC9
  Scenario: Successful registration with password of exact minimum required length (as per requirement)
    When I fill "First name" with "John"
    And I fill "Last name" with "Doe"
    And I fill "Email" with "{{random.email}}"
    And I fill "Age" with "30"
    And I select "Male" from "Gender"
    And I fill "Password" with "12345678"
    And I fill "Confirm password" with "12345678"
    And I check "I accept the terms"
    And I click the "Create account" button
    Then the URL should not contain "register.html"

  @TC-TC10
  Scenario: Verify input fields handle script tags safely
    When I fill "First name" with "<script>alert('XSS')</script>"
    And I fill "Last name" with "User"
    And I fill "Email" with "{{security.comment}}"
    And I fill "Age" with "25"
    And I select "Other" from "Gender"
    And I fill "Password" with "ValidPassword123!"
    And I fill "Confirm password" with "ValidPassword123!"
    And I check "I accept the terms"
    And I click the "Create account" button
    Then the "Email" field should be invalid

  @TC-TC11
  Scenario: Verify password fields mask input
    When I fill "Password" with "some-secret-text"
    Then the "Password" field should be masked
    When I fill "Confirm password" with "some-secret-text"
    Then the "Confirm password" field should be masked

  @TC-TC12
  Scenario: Verify navigation to login page from 'Login' link
    When I click the "Login" link
    Then the URL should contain "login.html"

  @TC-TC13
  Scenario: Verify keyboard navigation through form elements
    When I press the "Tab" key
    Then the "First name" field should be focused
    When I press the "Tab" key
    Then the "Last name" field should be focused
    When I press the "Tab" key
    Then the "Email" field should be focused
    When I press the "Tab" key
    Then the "Phone" field should be focused
    When I press the "Tab" key
    Then the "Age" field should be focused

  @TC-TC14
  Scenario: Verify form submission using Enter key
    When I fill "First name" with "Jane"
    And I fill "Last name" with "Doe"
    And I fill "Email" with "{{random.email}}"
    And I fill "Age" with "35"
    And I select "Female" from "Gender"
    And I fill "Password" with "ValidPassword123!"
    And I fill "Confirm password" with "ValidPassword123!"
    And I check "I accept the terms"
    And I press the "Enter" key
    Then the URL should not contain "register.html"
