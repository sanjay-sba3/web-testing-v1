@TS-66
Feature: New User Registration and Login

  As a user,
  I want to be able to register for a new account and log in,
  so that I can access the application's features.

  # needs-review: Test case specifies 'Username' and 'Register' button, but page has 'Given name', 'Family name', 'Email address' and 'Create account' button. Verifying actual fields from snapshot.
  @needs-review @TC-TC1
  Scenario: Verify registration page UI elements are visible
    Given I open the "http://localhost:8080/register.html" page
    Then I should see the "Given name" field
    And I should see the "Family name" field
    And I should see the "Email address" field
    And I should see the "Account password" field
    And I should see the "Confirm password" field
    And I should see the "Create account" button

  @TC-TC2
  Scenario: Verify login page UI elements are visible
    Given I open the "http://localhost:8080/login.html" page
    Then I should see the "Email" field
    And I should see the "Password" field
    And I should see the "Sign in" button

  @dryrun @TC-TC3
  Scenario: Successful user registration and subsequent login
    Given I open the "http://localhost:8080/register.html" page
    When I fill the registration form and remember the email
    Then the URL should not contain "register.html"
    And the URL should contain "login.html"
    When I log in with the remembered credentials
    Then the URL should contain "/dashboard"

  @TC-TC4
  Scenario: Registration - Submit with all required fields empty
    Given I open the "http://localhost:8080/register.html" page
    When I click the "Create account" button
    Then the "Given name" field should be invalid
    And the "Family name" field should be invalid
    And the "Email address" field should be invalid
    And the "Age (years)" field should be invalid
    And the "Account password" field should be invalid
    And the "I accept the terms and conditions" field should be invalid
    And the URL should contain "register.html"

  @TC-TC5
  Scenario: Registration - Submit with non-matching passwords
    Given I open the "http://localhost:8080/register.html" page
    When I fill "Given name" with "{{random.firstName}}"
    And I fill "Family name" with "{{random.lastName}}"
    And I fill "Email address" with "{{random.email}}"
    And I fill "Age (years)" with "30"
    And I select "Male" from "Gender identity"
    And I fill "Account password" with the value of env "APP_PASSWORD"
    And I fill "Confirm password" with "aDifferentPassword123"
    And I check "I accept the terms and conditions"
    When I click the "Create account" button
    Then I should see the text "Passwords do not match"
    And the URL should contain "register.html"

  @TC-TC6
  Scenario: Registration - Attempt to register with an existing email
    Given I open the "http://localhost:8080/register.html" page
    When I fill "Given name" with "{{random.firstName}}"
    And I fill "Family name" with "{{random.lastName}}"
    And I fill "Email address" with the value of env "APP_USERNAME"
    And I fill "Age (years)" with "30"
    And I select "Female" from "Gender identity"
    And I fill "Account password" with the value of env "APP_PASSWORD"
    And I fill "Confirm password" with the value of env "APP_PASSWORD"
    And I check "I accept the terms and conditions"
    When I click the "Create account" button
    Then I should see the text "Username is already taken"
    And the URL should contain "register.html"

  @TC-TC7
  Scenario: Login - Attempt with incorrect password
    Given I open the "http://localhost:8080/login.html" page
    When I fill "Email" with the value of env "APP_USERNAME"
    And I fill "Password" with "wrongpassword123!"
    When I click the "Sign in" button
    Then I should see the text "Login was unsuccessful"
    And the URL should contain "login.html"

  @TC-TC8
  Scenario: Login - Submit with empty email field
    Given I open the "http://localhost:8080/login.html" page
    When I fill "Password" with the value of env "APP_PASSWORD"
    When I click the "Sign in" button
    Then the "Email" field should be invalid
    And the URL should contain "login.html"

  @TC-TC9
  Scenario: Login - Submit with empty password field
    Given I open the "http://localhost:8080/login.html" page
    When I fill "Email" with the value of env "APP_USERNAME"
    When I click the "Sign in" button
    Then the "Password" field should be invalid
    And the URL should contain "login.html"

  @TC-TC10
  Scenario: Authorization - Unauthenticated user access to dashboard
    Given I open the "http://localhost:8080/dashboard" page
    Then the URL should contain "login.html"

  @TC-TC11
  Scenario: Security - Password field input masking
    Given I open the "http://localhost:8080/register.html" page
    Then the "Account password" field should be a password field
    And the "Confirm password" field should be a password field
    Given I open the "http://localhost:8080/login.html" page
    Then the "Password" field should be a password field

  @TC-TC12
  Scenario: Security - XSS prevention in registration email field
    Given I open the "http://localhost:8080/register.html" page
    When I fill "Given name" with "{{random.firstName}}"
    And I fill "Family name" with "{{random.lastName}}"
    And I fill "Email address" with "{{security.email}}"
    And I fill "Age (years)" with "25"
    And I select "Other" from "Gender identity"
    And I fill "Account password" with the value of env "APP_PASSWORD"
    And I fill "Confirm password" with the value of env "APP_PASSWORD"
    And I check "I accept the terms and conditions"
    When I click the "Create account" button
    Then the "Email address" field should be invalid

  # needs-review: Test case only checks a subset of the tab order.
  @needs-review @TC-TC13
  Scenario: Accessibility - Keyboard navigation on registration and login forms
    Given I open the "http://localhost:8080/register.html" page
    When I press the "Tab" key
    Then the "Given name" field should be focused
    When I press the "Tab" key
    Then the "Family name" field should be focused
    When I press the "Tab" key
    Then the "Email address" field should be focused
    Given I open the "http://localhost:8080/login.html" page
    When I press the "Tab" key
    Then the "Email" field should be focused
    When I press the "Tab" key
    Then the "Password" field should be focused
    When I press the "Tab" key
    Then the "Show" button should be focused
