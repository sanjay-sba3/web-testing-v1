@TS-52
Feature: User Registration

  Background:
    Given I open the "http://localhost:8080/register.html" page

  @dryrun @TC-TC1
  Scenario: Successful user registration with valid data
    When I fill "First Name" with "Test"
    When I fill "Last Name" with "User"
    When I fill "Email" with a unique email
    When I fill "Password" with the value of env "APP_PASSWORD"
    When I fill "Confirm Password" with the value of env "APP_PASSWORD"
    When I click the "Register" button
    Then the URL should contain "login.html"
    And I should see the text "Registration successful. Please login."

  @TC-TC2
  Scenario: Verify registration page UI elements are visible
    Then I should see the "Register" button
    And I should see the "Login" link

  @TC-TC3
  Scenario: Attempt registration with all required fields empty
    When I click the "Register" button
    Then the "First Name" field should show the error "First Name is required"
    And the "Last Name" field should show the error "Last Name is required"
    And the "Email" field should show the error "Email is required"
    And the "Password" field should show the error "Password is required"
    And the URL should contain "register.html"

  @TC-TC4
  Scenario: Attempt registration with an invalid email format
    When I fill "First Name" with "Test"
    When I fill "Last Name" with "User"
    When I fill "Email" with "invalid-email"
    When I fill "Password" with the value of env "APP_PASSWORD"
    When I fill "Confirm Password" with the value of env "APP_PASSWORD"
    When I click the "Register" button
    Then the "Email" field should show the error "Please enter a valid email address"
    And the URL should contain "register.html"

  @TC-TC5
  Scenario: Attempt registration with mismatched passwords
    When I fill "First Name" with "Test"
    When I fill "Last Name" with "User"
    When I fill "Email" with "test@example.com"
    When I fill "Password" with the value of env "APP_PASSWORD"
    When I fill "Confirm Password" with "differentPassword123!"
    When I click the "Register" button
    Then the "Confirm Password" field should show the error "Passwords do not match"

  @TC-TC6
  Scenario: Attempt registration with an existing email address
    When I fill "First Name" with "Jane"
    When I fill "Last Name" with "Doe"
    When I fill "Email" with "existing.user@example.com"
    When I fill "Password" with the value of env "APP_PASSWORD"
    When I fill "Confirm Password" with the value of env "APP_PASSWORD"
    When I click the "Register" button
    Then I should see the text "An account with this email already exists"

  @TC-TC7
  Scenario: Attempt registration with a password shorter than minimum length
    When I fill "First Name" with "Test"
    When I fill "Last Name" with "User"
    When I fill "Email" with "newuser@example.com"
    When I fill "Password" with "short"
    When I fill "Confirm Password" with "short"
    When I click the "Register" button
    Then the "Password" field should show the error "Password must be at least 8 characters long"

  @TC-TC8
  Scenario: Successful registration with a password of minimum required length
    When I fill "First Name" with "Test"
    When I fill "Last Name" with "Boundary"
    When I fill "Email" with a unique email
    When I fill "Password" with "12345678"
    When I fill "Confirm Password" with "12345678"
    When I click the "Register" button
    Then the URL should contain "login.html"

  @TC-TC9
  Scenario: Navigate to Login page from Registration page
    When I click the "Login" link
    Then the URL should contain "login.html"
    And I should see the text "Login to your account"

  @TC-TC10
  Scenario: Verify password fields mask user input
    When I fill "Password" with "a-secret-password"
    Then I should not see the text "a-secret-password"
    When I fill "Confirm Password" with "a-secret-password"
    Then I should not see the text "a-secret-password"

  @TC-TC11
  Scenario: Attempt XSS injection in a text field
    When I fill "First Name" with "<script>alert('XSS')</script>"
    When I fill "Last Name" with "User"
    When I fill "Email" with a unique email
    When I fill "Password" with the value of env "APP_PASSWORD"
    When I fill "Confirm Password" with the value of env "APP_PASSWORD"
    When I click the "Register" button
    Then no JavaScript alert dialog with the text "XSS" appears

  @TC-TC12
  Scenario: Verify keyboard tab navigation through form elements
    When I press the "Tab" key
    Then the "First Name" field is focused
    When I press the "Tab" key
    Then the "Last Name" field is focused
    When I press the "Tab" key
    Then the "Email" field is focused
    When I press the "Tab" key
    Then the "Password" field is focused
    When I press the "Tab" key
    Then the "Confirm Password" field is focused
    When I press the "Tab" key
    Then the "Register" button is focused
    When I press the "Tab" key
    Then the "Login" link is focused

  @TC-TC13
  Scenario: Submit registration form using Enter key
    When I fill "First Name" with "Keyboard"
    When I fill "Last Name" with "User"
    When I fill "Email" with a unique email
    When I fill "Password" with the value of env "APP_PASSWORD"
    When I fill "Confirm Password" with the value of env "APP_PASSWORD"
    When I tab until the "Register" button is focused
    When I press the "Enter" key
    Then the URL should contain "login.html"
    And I should see the text "Registration successful. Please login."
