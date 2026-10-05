@TS-79
Feature: User Registration and Login

  Background:
    Given I open the "/register" page

  @dryrun @TC-TC1
  Scenario: Successful User Registration
    When I fill "Given name" with "John"
    And I fill "Family name" with "Doe"
    And I fill "Email address" with "john.doe@example.com"
    And I fill "Mobile number" with "+1234567890"
    And I fill "Age (years" with "25"
    And I select "Male" from "Gender identity"
    And I fill "Account password" with "SecurePass123!"
    And I fill "Confirm password" with "SecurePass123!"
    And I check "I accept the terms and conditions"
    And I click the "Create account" button
    Then the URL should contain "/login"
    And I should see the text "Registration successful"

  @TC-TC2
  Scenario: Registration Without Required Fields
    When I click the "Create account" button
    Then the "Given name" field should be invalid
    And the "Family name" field should be invalid
    And the "Email address" field should be invalid
    And the "Age (years" field should be invalid
    And the "Gender identity" field should be invalid
    And the "Account password" field should be invalid
    And the "Confirm password" field should be invalid
    And the "I accept the terms and conditions" field should be invalid

  @TC-TC3
  Scenario: Invalid Email Format During Registration
    When I fill "Given name" with "John"
    And I fill "Family name" with "Doe"
    And I fill "Email address" with "{{negative.email}}"
    And I fill "Mobile number" with "+1234567890"
    And I fill "Age (years" with "25"
    And I select "Male" from "Gender identity"
    And I fill "Account password" with "SecurePass123!"
    And I fill "Confirm password" with "SecurePass123!"
    And I check "I accept the terms and conditions"
    And I click the "Create account" button
    Then the "Email address" field should be invalid

  @TC-TC4
  Scenario: Maximum Username Length Boundary Test
    # needs-review: No Username field on register.html (using Given name and Family name instead
    @needs-review @TC-TC4
  Scenario: Maximum Name Length Boundary Test
    When I fill "Given name" with "usernamethatisexactlyfiftycharacterslongandvalidxx"
    And I fill "Family name" with "validlast"
    And I fill "Email address" with "valid.email@example.com"
    And I fill "Mobile number" with "+1234567890"
    And I fill "Age (years" with "25"
    And I select "Male" from "Gender identity"
    And I fill "Account password" with "SecurePass123!"
    And I fill "Confirm password" with "SecurePass123!"
    And I check "I accept the terms and conditions"
    And I click the "Create account" button
    Then the URL should contain "/login"

  @TC-TC5
  Scenario: Exceed Maximum Username Length
    # needs-review: No Username field on register.html (using Given name and Family name instead
    @needs-review @TC-TC5
  Scenario: Exceed Maximum Name Length
    When I fill "Given name" with "usernamethatisoverfiftycharacterslongandshouldfailxxx"
    And I fill "Family name" with "validlast"
    And I fill "Email address" with "valid.email@example.com"
    And I fill "Mobile number" with "+1234567890"
    And I fill "Age (years" with "25"
    And I select "Male" from "Gender identity"
    And I fill "Account password" with "SecurePass123!"
    And I fill "Confirm password" with "SecurePass123!"
    And I check "I accept the terms and conditions"
    And I click the "Create account" button
    Then the "Given name" field should be invalid

  @TC-TC6
  Scenario: XSS Script Injection in Registration Fields
    # needs-review: No Username field on register.html (using Given name instead
    @needs-review @TC-TC6
  Scenario: XSS Script Injection in Given Name Field
    When I fill "Given name" with "{{security.comment}}"
    And I fill "Family name" with "Doe"
    And I fill "Email address" with "hacker@example.com"
    And I fill "Mobile number" with "+1234567890"
    And I fill "Age (years" with "25"
    And I select "Male" from "Gender identity"
    And I fill "Account password" with "SecurePass123!"
    And I fill "Confirm password" with "SecurePass123!"
    And I check "I accept the terms and conditions"
    And I click the "Create account" button
    Then the URL should contain "/login"

  @TC-TC7
  Scenario: Login Link Navigation After Registration
    When I click the "Sign in" link
    Then the URL should contain "/login"
    And I should see the "Email" field
    And I should see the "Password" field

  @TC-TC8
  Scenario: Valid Login Redirects to Dashboard
    Given I open the "/login" page
    When I fill "Email" with "john.doe@example.com"
    And I fill "Password" with "SecurePass123!"
    And I click the "Sign in" button
    Then the URL should contain "/dashboard"
    And I should see the text "Welcome"

  @TC-TC9
  Scenario: Empty Login Form Submission
    Given I open the "/login" page
    When I click the "Sign in" button
    Then the "Email" field should be invalid
    And the "Password" field should be invalid

  @TC-TC10
  Scenario: Incorrect Password Login Attempt
    Given I open the "/login" page
    When I fill "Email" with "john.doe@example.com"
    And I fill "Password" with "WrongPass123!"
    And I click the "Sign in" button
    Then I should see the text "Invalid credentials"

  @TC-TC11
  Scenario: Unauthenticated Access to Dashboard
    Given I open the "/dashboard" page
    Then the URL should contain "/login"
    And I should see the "Email" field
    And I should see the "Password" field

  @TC-TC12
  Scenario: Registration Page Field Presence
    Then I should see the "Given name" field
    And I should see the "Family name" field
    And I should see the "Email address" field
    And I should see the "Account password" field
    And I should see the "Confirm password" field
    And I should see the "Create account" button

  @TC-TC13
  Scenario: Login Page Field Presence
    Given I open the "/login" page
    Then I should see the "Email" field
    And I should see the "Password" field
    And I should see the "Sign in" button

  @TC-TC14
  Scenario: Dashboard Content Load Verification
    # This scenario requires prior authentication which is outside the scope of a single test
    @needs-review @TC-TC14
  Scenario: Dashboard Content Load Verification
    Given I am logged in
    When I open the "/dashboard" page
    Then I should see the text "Welcome"
    And I should see navigation menu items

  @TC-TC15
  Scenario: Password Masking During Input
    When I fill "Account password" with "SecurePass123!"
    Then the "Account password" field should mask the input
    Given I open the "/login" page
    When I fill "Password" with "SecurePass123!"
    Then the "Password" field should mask the input

  @TC-TC16
  Scenario: Keyboard Accessibility of Forms
    When I press the "Tab" key
    Then the "Given name" field should be focused
    When I press the "Tab" key
    Then the "Family name" field should be focused
    When I press the "Tab" key
    Then the "Email address" field should be focused
    When I press the "Tab" key
    Then the "Mobile number" field should be focused
    When I press the "Tab" key
    Then the "Age (years" field should be focused
    When I press the "Tab" key
    Then the "Gender identity" field should be focused
    When I press the "Tab" key
    Then the "Account password" field should be focused
    When I press the "Tab" key
    Then the "Confirm password" field should be focused
    When I press the "Tab" key
    Then the "I accept the terms and conditions" field should be focused
    When I press the "Tab" key
    Then the "Create account" button should be focused