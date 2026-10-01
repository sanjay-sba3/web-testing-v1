@TS-68
Feature: New User Registration and Login

  As a user, I want to be able to register a new account and log in, so that I can access the application.

  # needs-review: Test case uses "Username", "Password", "Confirm Password", "Register", but snapshot has "Email address", "Account password", "Confirm password", "Create account"
  @needs-review @TC-TC1
  Scenario: Verify registration page UI elements are displayed
    Given I open the "http://localhost:8080/register.html" page
    Then I should see the "Given name" button
    Then I should see the "Account password" button
    Then I should see the "Confirm password" button
    Then I should see the "Create account" button

  # needs-review: Test case uses "Username", "Password", "Login", but snapshot has "Email", "Password", "Sign in"
  @needs-review @TC-TC2
  Scenario: Verify login page UI elements are displayed
    Given I open the "http://localhost:8080/login.html" page
    Then I should see the "Email" button
    Then I should see the "Password" button
    Then I should see the "Sign in" button

  # needs-review: Test case uses ${APP_PASSWORD}, but register form requires minlength=6. Using a known valid password "ValidPass123" instead.
  @dryrun @TC-TC3
  Scenario: Successful registration with unique credentials
    Given I open the "http://localhost:8080/register.html" page
    When I fill "Given name" with "{{random.firstName}}"
    And I fill "Family name" with "{{random.lastName}}"
    And I fill "Email address" with "{{random.email}}"
    And I fill "Age (years)" with "25"
    And I select "Female" from "Gender identity"
    And I fill "Account password" with "ValidPass123"
    And I fill "Confirm password" with "ValidPass123"
    And I check "I accept the terms and conditions"
    And I click the "Create account" button
    Then the URL should contain "/login.html"

  # needs-review: Dashboard URL not provided in captures, assuming it contains "/dashboard".
  @dryrun @TC-TC4
  Scenario: Successful login with valid credentials
    Given I open the "http://localhost:8080/login.html" page
    When I fill "Email" with the value of env "APP_USERNAME"
    And I fill "Password" with the value of env "APP_PASSWORD"
    And I click the "Sign in" button
    Then the URL should contain "/dashboard"

  # needs-review: Test case says "Username" is empty, but this field doesn't exist. Applying to "Given name" as the first required text field.
  @needs-review @TC-TC5
  Scenario: Attempt registration with an empty required field
    Given I open the "http://localhost:8080/register.html" page
    When I fill "Family name" with "{{random.lastName}}"
    And I fill "Email address" with "{{random.email}}"
    And I fill "Age (years)" with "25"
    And I select "Female" from "Gender identity"
    And I fill "Account password" with "ValidPass123"
    And I fill "Confirm password" with "ValidPass123"
    And I check "I accept the terms and conditions"
    And I click the "Create account" button
    Then the "Given name" field should be invalid

  @TC-TC6
  Scenario: Attempt registration with non-matching passwords
    Given I open the "http://localhost:8080/register.html" page
    When I fill "Given name" with "{{random.firstName}}"
    And I fill "Family name" with "{{random.lastName}}"
    And I fill "Email address" with "{{random.email}}"
    And I fill "Age (years)" with "25"
    And I select "Female" from "Gender identity"
    And I fill "Account password" with "ValidPass123"
    And I fill "Confirm password" with "OtherPassword456"
    And I check "I accept the terms and conditions"
    And I click the "Create account" button
    Then the "Confirm password" field should be invalid

  # needs-review: This test assumes APP_USERNAME is a pre-registered user and is an email, which may conflict with 'self-contained tests' principle.
  @needs-review @TC-TC7
  Scenario: Attempt registration with an existing username
    Given I open the "http://localhost:8080/register.html" page
    When I fill "Given name" with "{{random.firstName}}"
    And I fill "Family name" with "{{random.lastName}}"
    And I fill "Email address" with the value of env "APP_USERNAME"
    And I fill "Age (years)" with "25"
    And I select "Female" from "Gender identity"
    And I fill "Account password" with "ValidPass123"
    And I fill "Confirm password" with "ValidPass123"
    And I check "I accept the terms and conditions"
    And I click the "Create account" button
    Then I should see the text "username is taken"

  @TC-TC8
  Scenario: Attempt login with an incorrect password
    Given I open the "http://localhost:8080/login.html" page
    When I fill "Email" with the value of env "APP_USERNAME"
    And I fill "Password" with "wrongpassword"
    And I click the "Sign in" button
    Then I should see the text "invalid credentials"

  @TC-TC9
  Scenario: Attempt login with a non-existent username
    Given I open the "http://localhost:8080/login.html" page
    When I fill "Email" with "{{random.email}}"
    And I fill "Password" with the value of env "APP_PASSWORD"
    And I click the "Sign in" button
    Then I should see the text "invalid credentials"

  @TC-TC10
  Scenario: Attempt login with an empty username field
    Given I open the "http://localhost:8080/login.html" page
    When I fill "Password" with the value of env "APP_PASSWORD"
    And I click the "Sign in" button
    Then the "Email" field should be invalid

  # needs-review: Dashboard URL not provided in captures, using "/dashboard.html" as placeholder.
  @needs-review @TC-TC11
  Scenario: Unauthorized navigation to dashboard page
    Given I open the "/dashboard.html" page
    Then the URL should contain "/login.html"

  @TC-TC12
  Scenario: Verify password input is masked
    Given I open the "http://localhost:8080/login.html" page
    When I fill "Password" with "some-secret-password"
    Then the "Password" field should be masked

  @TC-TC13
  Scenario: Prevent XSS in registration username field
    Given I open the "http://localhost:8080/register.html" page
    When I fill "Given name" with "{{security.username}}"
    And I fill "Family name" with "{{random.lastName}}"
    And I fill "Email address" with "{{random.email}}"
    And I fill "Age (years)" with "25"
    And I select "Female" from "Gender identity"
    And I fill "Account password" with "ValidPass123"
    And I fill "Confirm password" with "ValidPass123"
    And I check "I accept the terms and conditions"
    And I click the "Create account" button
    Then the URL should contain "/login.html"

  # needs-review: Test case tab order is incomplete and uses incorrect names. Following snapshot order.
  @needs-review @TC-TC14
  Scenario: Keyboard navigation on registration page
    Given I open the "http://localhost:8080/register.html" page
    When I press the "Tab" key
    Then the "Given name" textbox should be focused
    When I press the "Tab" key
    Then the "Family name" textbox should be focused
    When I press the "Tab" key
    Then the "Email address" textbox should be focused
    When I press the "Tab" key
    Then the "Mobile number" textbox should be focused
    When I press the "Tab" key
    Then the "Age (years)" spinbutton should be focused
    When I press the "Tab" key
    Then the "Gender identity" combobox should be focused
    When I press the "Tab" key
    Then the "Account password" textbox should be focused
    When I press the "Tab" key
    Then the "Confirm password" textbox should be focused
    When I press the "Tab" key
    Then the "I accept the terms and conditions" checkbox should be focused
    When I press the "Tab" key
    Then the "Create account" button should be focused

  # needs-review: Test case tab order is incomplete and uses incorrect names. Following snapshot order.
  @needs-review @TC-TC15
  Scenario: Keyboard navigation on login page
    Given I open the "http://localhost:8080/login.html" page
    When I press the "Tab" key
    Then the "Email" textbox should be focused
    When I press the "Tab" key
    Then the "Password" textbox should be focused
    When I press the "Tab" key
    Then the "Remember my email" checkbox should be focused
    When I press the "Tab" key
    Then the "Sign in" button should be focused
