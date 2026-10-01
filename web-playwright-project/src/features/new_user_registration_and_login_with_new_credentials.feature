@TS-73
Feature: New User Registration and Login

  As a new user, I want to be able to register for an account and then log in.

  @dryrun @TC-TC1
  Scenario: Successful user registration and subsequent login
    Given I open the "http://localhost:3000/register" page
    When I register a new user
    Then the URL should be "http://localhost:3000/login"
    When I sign in as that new user
    Then the URL should contain "/dashboard"

  @TC-TC2
  Scenario: Verify registration page UI elements are present
    Given I open the "http://localhost:3000/register" page
    Then the registration form is displayed correctly

  @TC-TC3
  Scenario: Verify login page UI elements are present
    Given I open the "http://localhost:3000/login" page
    Then the login form is displayed correctly

  # needs-review: Browser validation typically flags only the first invalid field on submit, not all at once.
  @needs-review @TC-TC4
  Scenario: Attempt registration with all fields empty
    Given I open the "http://localhost:3000/register" page
    When I click the "Create account" button
    Then the "Given name" field should be invalid
    And the "Email address" field should be invalid
    And the "Account password" field should be invalid
    And the "Confirm password" field should be invalid

  @TC-TC5
  Scenario: Attempt registration with an invalid email format
    Given I open the "http://localhost:3000/register" page
    When I fill all required registration fields
    And I fill "Email address" with "{{negative.email}}"
    When I click the "Create account" button
    Then the "Email address" field should be invalid

  @TC-TC6
  Scenario: Attempt registration with mismatching passwords
    Given I open the "http://localhost:3000/register" page
    When I fill all required registration fields
    And I fill "Account password" with "PasswordA123"
    And I fill "Confirm password" with "PasswordB456"
    When I click the "Create account" button
    # needs-review: The test case specifies an error message "passwords do not match". If this is a custom on-page message, this step should be `Then I should see the text "passwords do not match"`. If it uses standard browser validation, this step is more appropriate.
    Then the "Confirm password" field should be invalid

  @TC-TC7
  Scenario: Attempt registration with an already registered email
    Given I open the "http://localhost:3000/register" page
    When I fill all required registration fields
    And I fill "Email address" with the value of env "APP_USERNAME"
    And I fill "Account password" with "AnyValidPassword123"
    And I fill "Confirm password" with "AnyValidPassword123"
    When I click the "Create account" button
    # needs-review: The test case specifies an error message "user already exists". If this is a custom on-page message, this step should be `Then I should see the text "user already exists"`. Without seeing the page's response, this is a guess.
    Then the URL should not contain "/login"

  @TC-TC8
  Scenario: Attempt login with incorrect credentials
    Given I open the "http://localhost:3000/login" page
    When I fill "Email" with the value of env "APP_USERNAME"
    And I fill "Password" with "IncorrectPassword123!"
    When I click the "Sign in" button
    # needs-review: The test case specifies an error message "invalid credentials". If this is a custom on-page message, this step should be `Then I should see the text "invalid credentials"`. Without seeing the page's response, this is a guess.
    Then the URL should not contain "/dashboard"

  # needs-review: Browser validation typically flags only the first invalid field on submit, not all at once.
  @needs-review @TC-TC9
  Scenario: Attempt login with empty credentials
    Given I open the "http://localhost:3000/login" page
    When I click the "Sign in" button
    Then the "Email" field should be invalid
    And the "Password" field should be invalid

  @TC-TC10
  Scenario: Unauthorized access attempt to dashboard page
    Given I open the "http://localhost:3000/dashboard" page
    Then the URL should contain "/login"

  @TC-TC11
  Scenario: Verify password fields mask input
    Given I open the "http://localhost:3000/register" page
    When I fill "Account password" with "MySecretPassword123"
    Then the text in the "Account password" field is masked
    When I fill "Confirm password" with "MySecretPassword123"
    Then the text in the "Confirm password" field is masked
    Given I open the "http://localhost:3000/login" page
    When I fill "Password" with "MySecretPassword123"
    Then the text in the "Password" field is masked

  @TC-TC12
  Scenario: Prevent XSS in registration email field
    Given I open the "http://localhost:3000/register" page
    When I fill all required registration fields
    And I fill "Email address" with "{{security.comment}}"
    When I click the "Create account" button
    # The absence of an unhandled dialog error from Playwright confirms no alert was displayed.
    Then the "Email address" field should be invalid
