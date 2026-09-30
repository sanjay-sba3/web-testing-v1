@TS-55
Feature: Register
  As a new user
  I want to create an account
  So that I can access the application's features

  Background:
    Given I open the "http://localhost:8080/register.html" page

  @TC-TC1
  Scenario: Verify registration page UI elements are visible
    Then I should see the text "First name"
    Then I should see the text "Last name"
    Then I should see the text "Email"
    Then I should see the text "Password"
    Then I should see the text "Confirm password"
    Then I should see the "Create account" button

  @dryrun @TC-TC2
  Scenario: Successful user registration with valid data
    When I fill "First name" with "John"
    When I fill "Last name" with "Doe"
    When I fill "Email" with the "user.email" from test data
    When I fill "Password" with the "user.password" from test data
    When I fill "Confirm password" with the "user.password" from test data
    When I click the "Create account" button
    Then the URL should contain "/login.html"

  @TC-TC3
  Scenario Outline: Verify required field validation for all empty fields
    When I click the "Create account" button
    Then the "<Field>" field shows the error "<Message>"

    Examples:
      | Field        | Message                 |
      | First name   | First Name is required  |
      | Last name    | Last Name is required   |
      | Email        | Email is required       |
      | Password     | Password is required    |

  @TC-TC4
  Scenario: Verify email format validation
    When I fill "First name" with "Jane"
    When I fill "Last name" with "Smith"
    When I fill "Email" with the "validation.invalidEmail" from test data
    When I fill "Password" with "Password123!"
    When I fill "Confirm password" with "Password123!"
    When I click the "Create account" button
    Then the "Email" field shows the error "Please enter a valid email address"
    And the URL should not contain "/login.html"

  @TC-TC5
  Scenario: Verify password confirmation mismatch validation
    When I fill "First name" with "Test"
    When I fill "Last name" with "User"
    When I fill "Email" with the "user.email" from test data
    When I fill "Password" with the "user.password" from test data
    When I fill "Confirm password" with the "validation.nonMatchingPassword" from test data
    When I click the "Create account" button
    Then the "Confirm password" field shows the error "Passwords do not match"

  @TC-TC6
  Scenario: Verify password minimum length validation (less than 8 characters)
    When I fill "First name" with "Boundary"
    When I fill "Last name" with "Case"
    When I fill "Email" with the "user.email" from test data
    When I fill "Password" with the "validation.shortPassword" from test data
    When I fill "Confirm password" with the "validation.shortPassword" from test data
    When I click the "Create account" button
    Then the "Password" field shows the error "Password must be at least 8 characters long"

  @TC-TC7
  Scenario: Verify successful registration with minimum length password (8 characters)
    When I fill "First name" with "Boundary"
    When I fill "Last name" with "Success"
    When I fill "Email" with the "user.email" from test data
    When I fill "Password" with the "validation.minLenPassword" from test data
    When I fill "Confirm password" with the "validation.minLenPassword" from test data
    When I click the "Create account" button
    Then the URL should contain "/login.html"

  @TC-TC8
  Scenario: Verify navigation to login page from 'Log in' link
    When I click the "Login" link
    Then the URL should contain "/login.html"

  @TC-TC9
  Scenario: Verify logged-in user is redirected from registration page
    # Precondition: User is already logged in. This test assumes a pre-authenticated state.
    Then the URL should contain "/dashboard"

  @TC-TC10
  Scenario: Verify password fields mask user input
    When I fill "Password" with "a-secret-password"
    Then the "Password" field input is masked
    When I fill "Confirm password" with "a-secret-password"
    Then the "Confirm password" field input is masked

  @TC-TC11
  Scenario: Verify XSS protection in name fields
    Given I am listening for browser alerts
    When I fill "First name" with the "user.xssFirstName" from test data
    And I fill "Last name" with "User"
    And I fill "Email" with the "user.email" from test data
    And I fill "Password" with the "user.password" from test data
    And I fill "Confirm password" with the "user.password" from test data
    And I click the "Create account" button
    Given I open the "http://localhost:8080/login.html" page
    When I fill "Email" with the "user.email" from test data
    And I fill "Password" with the "user.password" from test data
    And I click the "Log in" button
    Then I should see the text "<script>alert('XSS')</script>"
    And no browser alert dialog should have appeared

  @TC-TC12
  Scenario: Verify form navigation using Tab key
    When I press the Tab key
    Then the "First name" field is focused
    When I press the Tab key
    Then the "Last name" field is focused
    When I press the Tab key
    Then the "Email" field is focused
    When I press the Tab key
    Then the "Password" field is focused
    When I press the Tab key
    Then the "Confirm password" field is focused
    When I press the Tab key
    Then the "Create account" button is focused

  @TC-TC13
  Scenario: Verify all input fields have associated labels
    When I click the label text "First name"
    Then the "First name" input field is focused
    When I click the label text "Last name"
    Then the "Last name" input field is focused
    When I click the label text "Email"
    Then the "Email" input field is focused
    When I click the label text "Password"
    Then the "Password" input field is focused
