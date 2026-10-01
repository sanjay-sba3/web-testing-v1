@TS-67
Feature: New User Registration

  Background:
    Given I open the "http://localhost:8080/register.html" page

  @dryrun @TC-TC2 @TC-TC12
  Scenario: Successful User Registration
    When I fill "Given name" with "{{random.givenName}}"
    And I fill "Family name" with "{{random.familyName}}"
    And I fill "Email address" with "{{random.email}}"
    And I fill "Age (years)" with "30"
    And I select "Male" from "Gender identity"
    And I fill "Account password" with "ValidPass123!"
    And I fill "Confirm password" with "ValidPass123!"
    And I check "I accept the terms and conditions"
    And I click the "Create account" button
    Then the URL should contain "/login.html"

  @TC-TC1
  Scenario: Verify Registration Page UI Elements
    Then I should see the "Register" heading
    Then I should see the "Given name" field
    Then I should see the "Family name" field
    Then I should see the "Email address" field
    Then I should see the "Account password" field
    Then I should see the "Confirm password" field
    Then I should see the "Create account" button

  @TC-TC3
  Scenario: Attempt Registration with All Fields Empty
    When I click the "Create account" button
    Then the "Given name" field should be invalid
    And the "Family name" field should be invalid
    And the "Email address" field should be invalid
    And the "Age (years)" field should be invalid
    And the "Account password" field should be invalid
    And the "Confirm password" field should be invalid
    And the "I accept the terms and conditions" field should be invalid

  @TC-TC4
  Scenario: Attempt Registration with Invalid Email Format
    When I fill "Given name" with "{{random.givenName}}"
    And I fill "Family name" with "{{random.familyName}}"
    And I fill "Email address" with "{{negative.email}}"
    And I fill "Age (years)" with "30"
    And I select "Female" from "Gender identity"
    And I fill "Account password" with "ValidPass123!"
    And I fill "Confirm password" with "ValidPass123!"
    And I check "I accept the terms and conditions"
    And I click the "Create account" button
    Then the "Email address" field should be invalid

  @TC-TC5
  Scenario: Attempt Registration with Mismatched Passwords
    When I fill "Given name" with "{{random.givenName}}"
    And I fill "Family name" with "{{random.familyName}}"
    And I fill "Email address" with "{{random.email}}"
    And I fill "Age (years)" with "30"
    And I select "Other" from "Gender identity"
    And I fill "Account password" with "ValidPass123!"
    And I fill "Confirm password" with "DifferentPass456!"
    And I check "I accept the terms and conditions"
    And I click the "Create account" button
    # The browser's built-in validation requires custom JavaScript to link two fields.
    # This step assumes such a script exists and sets the field's validity state.
    Then the "Confirm password" field should be invalid

  @TC-TC6
  Scenario: Attempt Registration with Password Shorter than Minimum Length
    When I fill "Given name" with "{{random.givenName}}"
    And I fill "Family name" with "{{random.familyName}}"
    And I fill "Email address" with "{{random.email}}"
    And I fill "Age (years)" with "30"
    And I select "Prefer not to say" from "Gender identity"
    And I fill "Account password" with "short"
    And I fill "Confirm password" with "short"
    And I check "I accept the terms and conditions"
    And I click the "Create account" button
    Then the "Account password" field should be invalid

  # needs-review: no "Username" field on register.html (fields: "Given name", "Family name"). Test uses 'Given name' as a proxy for 'username'.
  @needs-review @TC-TC7
  Scenario: Attempt Registration with an Existing Username
    When I fill "Given name" with the value of env "APP_USERNAME"
    And I fill "Family name" with "{{random.familyName}}"
    And I fill "Email address" with "{{random.email}}"
    And I fill "Age (years)" with "30"
    And I select "Male" from "Gender identity"
    And I fill "Account password" with "ValidPass123!"
    And I fill "Confirm password" with "ValidPass123!"
    And I check "I accept the terms and conditions"
    And I click the "Create account" button
    Then I should see the text "username is already taken"

  @TC-TC8
  Scenario: Verify Password and Confirm Password Fields are Masked
    When I fill "Account password" with "any text"
    Then the "Account password" field should be a password field
    When I fill "Confirm password" with "any text"
    Then the "Confirm password" field should be a password field

  @TC-TC9
  Scenario: Verify Navigation to Login Page from Registration Page
    When I click the "Login" link
    Then the URL should contain "/login.html"

  @TC-TC10
  Scenario: Verify XSS Prevention in Input Field During Validation Error
    When I fill "Given name" with "{{security.comment}}"
    And I fill "Family name" with "{{random.familyName}}"
    And I fill "Email address" with "{{random.email}}"
    And I fill "Age (years)" with "30"
    And I select "Male" from "Gender identity"
    And I fill "Account password" with "ValidPass123!"
    And I fill "Confirm password" with "a-different-password"
    And I check "I accept the terms and conditions"
    And I click the "Create account" button
    Then the URL should not contain "/login.html"
    And I should not see the text "<script>"

  @TC-TC11
  Scenario: Verify Keyboard Navigation using Tab Key
    When I press the "Tab" key
    Then the "Given name" field should be focused
    When I press the "Tab" key
    Then the "Family name" field should be focused
    When I press the "Tab" key
    Then the "Email address" field should be focused
    When I press the "Tab" key
    Then the "Mobile number" field should be focused
    When I press the "Tab" key
    Then the "Age (years)" field should be focused
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

  @TC-TC12
  Scenario: Verify Form Submission using Enter Key
    When I fill "Given name" with "{{random.givenName}}"
    And I fill "Family name" with "{{random.familyName}}"
    And I fill "Email address" with "{{random.email}}"
    And I fill "Age (years)" with "30"
    And I select "Male" from "Gender identity"
    And I fill "Account password" with "ValidPass123!"
    And I check "I accept the terms and conditions"
    And I fill "Confirm password" with "ValidPass123!"
    And I press the "Enter" key
    Then the URL should contain "/login.html"