@TS-74
Feature: New user registration and login with new credentials

  A new user registers on the registration page, then signs in with those same
  credentials and lands on the dashboard.

  @dryrun @TC-TC1
  Scenario: Register a new account with valid details
    Given I open the "http://localhost:3000/register" page
    When I fill "Given name" with "{{random.firstName}}"
    And I fill "Family name" with "{{random.lastName}}"
    And I fill "Email address" with "{{random.email}}"
    And I fill "Mobile number" with "9876543210"
    And I fill "Age (years)" with "30"
    And I select "Female" from "Gender identity"
    And I fill "Account password" with the value of env "APP_PASSWORD"
    And I fill "Confirm password" with the value of env "APP_PASSWORD"
    And I check "I accept the terms and conditions"
    And I click the "Create account" button
    Then the URL should not contain "/register"

  @dryrun @TC-TC2
  Scenario: Log in with the newly registered account and land on the dashboard
    Given I open the "http://localhost:3000/register" page
    When I register a new user
    And I open the "http://localhost:3000/login" page
    And I sign in as that new user
    Then the URL should contain "/dashboard"
    And the URL should not contain "/login"

  @TC-TC3
  Scenario: Registration form rejects submission with required fields empty
    Given I open the "http://localhost:3000/register" page
    When I click the "Create account" button
    Then the "Email address" field should be invalid
    And the "Account password" field should be invalid
    And the URL should contain "/register"

  @TC-TC4
  Scenario: Registration rejects an email in an invalid format
    Given I open the "http://localhost:3000/register" page
    When I fill "Given name" with "{{random.firstName}}"
    And I fill "Family name" with "{{random.lastName}}"
    And I fill "Email address" with "{{negative.email}}"
    And I fill "Mobile number" with "9876543210"
    And I fill "Age (years)" with "30"
    And I select "Female" from "Gender identity"
    And I fill "Account password" with the value of env "APP_PASSWORD"
    And I fill "Confirm password" with the value of env "APP_PASSWORD"
    And I check "I accept the terms and conditions"
    And I click the "Create account" button
    Then the "Email address" field should be invalid
    And the URL should contain "/register"

  @TC-TC5
  Scenario: Registration rejects an email that is already registered
    Given I open the "http://localhost:3000/register" page
    When I register a new user
    And I open the "http://localhost:3000/register" page
    And I register a user with the same email again
    Then the URL should contain "/register"

  # needs-review: the submitted name is only echoed after registration (dashboard page), which was not captured - no element exists to assert the escaped text against, so only the dialog check runs
  @needs-review @TC-TC6
  Scenario: Registration shows entered script text as plain text
    Given I open the "http://localhost:3000/register" page
    When I start watching for browser dialogs
    And I fill "Given name" with "{{security.comment}}"
    And I fill "Family name" with "{{random.lastName}}"
    And I fill "Email address" with "{{random.email}}"
    And I fill "Mobile number" with "9876543210"
    And I fill "Age (years)" with "30"
    And I select "Female" from "Gender identity"
    And I fill "Account password" with the value of env "APP_PASSWORD"
    And I fill "Confirm password" with the value of env "APP_PASSWORD"
    And I check "I accept the terms and conditions"
    And I click the "Create account" button
    Then no browser dialog should have opened

  @TC-TC7
  Scenario: Registration password field masks typed characters
    Given I open the "http://localhost:3000/register" page
    When I fill "Account password" with the value of env "APP_PASSWORD"
    Then the "Account password" password field should be masked

  @TC-TC8
  Scenario: Complete registration using only the keyboard
    Given I open the "http://localhost:3000/register" page
    When I complete the registration form using only the keyboard
    Then the URL should not contain "/register"

  @TC-TC9
  Scenario: Login form rejects submission with the password empty
    Given I open the "http://localhost:3000/login" page
    When I fill "Email" with the value of env "APP_USERNAME"
    And I click the "Sign in" button
    Then the "Password" field should be invalid
    And the URL should contain "/login"

  @TC-TC10
  Scenario: Login rejects a correct email with an incorrect password
    Given I open the "http://localhost:3000/login" page
    When I fill "Email" with the value of env "APP_USERNAME"
    And I fill "Password" with "WrongPassword123!"
    And I click the "Sign in" button
    Then the URL should contain "/login"
    And the URL should not contain "/dashboard"

  @TC-TC11
  Scenario: Login rejects an email that has never been registered
    Given I open the "http://localhost:3000/login" page
    When I fill "Email" with "{{random.email}}"
    And I fill "Password" with the value of env "APP_PASSWORD"
    And I click the "Sign in" button
    Then the URL should contain "/login"
    And the URL should not contain "/dashboard"

  @TC-TC12
  Scenario: Password is not exposed in the URL after login submission
    Given I open the "http://localhost:3000/login" page
    When I fill "Email" with the value of env "APP_USERNAME"
    And I fill "Password" with the value of env "APP_PASSWORD"
    And I click the "Sign in" button
    Then the URL should contain "/dashboard"
    And the URL should not contain the value of env "APP_PASSWORD"
    And the URL should not contain "password"

  @TC-TC13
  Scenario: Login password field masks typed characters
    Given I open the "http://localhost:3000/login" page
    When I fill "Password" with the value of env "APP_PASSWORD"
    Then the "Password" password field should be masked

  @TC-TC14
  Scenario: Unauthenticated access to the dashboard redirects to login
    Given I open the "http://localhost:3000/dashboard" page
    Then the URL should contain "/login"
    And I should see the "Sign in" button
    And the URL should not contain "/dashboard"

  @TC-TC15
  Scenario: Dashboard session survives a page reload
    Given I open the "http://localhost:3000/login" page
    When I fill "Email" with the value of env "APP_USERNAME"
    And I fill "Password" with the value of env "APP_PASSWORD"
    And I click the "Sign in" button
    Then the URL should contain "/dashboard"
    When I reload the page
    Then the URL should contain "/dashboard"
    And the URL should not contain "/login"

  @TC-TC16
  Scenario: Complete login using only the keyboard and reach the dashboard
    Given I open the "http://localhost:3000/login" page
    When I sign in using only the keyboard
    Then the URL should contain "/dashboard"
