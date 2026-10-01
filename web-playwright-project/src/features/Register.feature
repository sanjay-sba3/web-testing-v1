@TS-63
Feature: User Registration

  Background:
    Given I open the "http://localhost:8080/register.html" page

  @dryrun @TC-TC1
  Scenario: Successful registration with all valid data
    When I fill "Given name" with "{{random.firstName}}"
    And I fill "Family name" with "{{random.lastName}}"
    And I fill "Email address" with "{{random.email}}"
    And I fill "Mobile number" with "+1 555 123 4567"
    And I fill "Age (years)" with "25"
    And I select "Male" from "Gender identity"
    And I fill "Account password" with "ValidPassword123!"
    And I fill "Confirm password" with "ValidPassword123!"
    And I check "I accept the terms and conditions"
    And I click the "Create account" button
    Then the URL should contain "login.html"

  @TC-TC2
  Scenario: Verify registration page UI elements are displayed
    Then I should see the text "Given name"
    And I should see the text "Family name"
    And I should see the text "Email address"
    And I should see the text "Account password"
    And I should see the text "Confirm password"
    And I should see the "Create account" button
    And I should see the "Login" link

  @TC-TC3
  Scenario: Attempt registration with all required fields empty
    When I click the "Create account" button
    Then the "Given name" field should be invalid

  @TC-TC4
  Scenario: Attempt registration with an invalid email format
    When I fill "Given name" with "Jane"
    And I fill "Family name" with "Doe"
    And I fill "Email address" with "{{negative.email}}"
    And I fill "Mobile number" with "+1 555 123 4567"
    And I fill "Age (years)" with "30"
    And I select "Female" from "Gender identity"
    And I fill "Account password" with "ValidPassword123!"
    And I fill "Confirm password" with "ValidPassword123!"
    And I check "I accept the terms and conditions"
    And I click the "Create account" button
    Then the "Email address" field should be invalid

  @TC-TC5
  Scenario: Attempt registration with mismatching passwords
    When I fill "Given name" with "Alex"
    And I fill "Family name" with "Smith"
    And I fill "Email address" with "{{random.email}}"
    And I fill "Mobile number" with "+1 555 123 4567"
    And I fill "Age (years)" with "33"
    And I select "Other" from "Gender identity"
    And I fill "Account password" with "PasswordA123!"
    And I fill "Confirm password" with "PasswordB456!"
    And I check "I accept the terms and conditions"
    And I click the "Create account" button
    Then the "Confirm password" field should be invalid

  @TC-TC6
  Scenario: Attempt registration with a password shorter than minimum length
    When I fill "Given name" with "Chris"
    And I fill "Family name" with "Green"
    And I fill "Email address" with "{{random.email}}"
    And I fill "Mobile number" with "+1 555 123 4567"
    And I fill "Age (years)" with "21"
    And I select "Prefer not to say" from "Gender identity"
    And I fill "Account password" with "short"
    And I fill "Confirm password" with "short"
    And I check "I accept the terms and conditions"
    And I click the "Create account" button
    Then the "Account password" field should be invalid

  @TC-TC7
  Scenario: Navigate from registration to login page via link
    When I click the "Login" link
    Then the URL should contain "login.html"

  @TC-TC8
  Scenario: Verify XSS protection on form input fields
    When I fill "Given name" with "{{security.comment}}"
    And I fill "Family name" with "Secure"
    And I fill "Email address" with ""
    And I fill "Mobile number" with "+1 555 123 4567"
    And I fill "Age (years)" with "40"
    And I select "Male" from "Gender identity"
    And I fill "Account password" with "ValidPassword123!"
    And I fill "Confirm password" with "ValidPassword123!"
    And I check "I accept the terms and conditions"
    And I click the "Create account" button
    Then the "Email address" field should be invalid
    And the value of the "Given name" field should be "{{security.comment}}"

  @TC-TC9
  Scenario: Verify password fields are masked
    When I fill "Account password" with "MySecretPassword123"
    And I fill "Confirm password" with "MySecretPassword123"
    Then the "Account password" field should be masked
    And the "Confirm password" field should be masked

  @TC-TC10
  Scenario: Navigate and submit form using only the keyboard
    When I fill "Given name" with "Keyboard"
    And I fill "Family name" with "User"
    And I fill "Email address" with "{{random.email}}"
    And I fill "Mobile number" with "+1 555 123 4567"
    And I fill "Age (years)" with "35"
    And I select "Male" from "Gender identity"
    And I fill "Account password" with "KeyboardUserPass1!"
    And I fill "Confirm password" with "KeyboardUserPass1!"
    And I check "I accept the terms and conditions"
    And I press the "Tab" key
    And I press the "Enter" key
    Then the URL should contain "login.html"
