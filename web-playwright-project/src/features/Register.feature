@TS-54
Feature: User Registration
  As a new user
  I want to register for an account
  So that I can access the application's features

  Background:
    Given I open the "http://localhost:8080/register.html" page

  @dryrun @TC-TC1
  Scenario: Successful user registration with valid and unique credentials
    When I fill "Username" with "{{random.username}}"
    And I fill "Email" with "{{random.email}}"
    And I fill "Password" with "{{random.password}}"
    And I fill "Confirm Password" with "{{random.password}}"
    And I click the "Register" button
    Then the URL should contain "confirmation"
    And I should see the text "Registration successful!"

  @TC-TC2
  Scenario: Verify registration page UI elements are visible
    Then I should see the "Username" input field
    And I should see the "Email" input field
    And I should see the "Password" input field
    And I should see the "Confirm Password" input field
    And I should see the "Register" button
    And I should see the "Login" link

  @TC-TC3
  Scenario: Attempt registration with all fields empty
    When I click the "Register" button
    Then I should see the text "Username is required"
    And I should see the text "Email is required"
    And I should see the text "Password is required"
    And I should see the text "Confirm Password is required"

  @TC-TC4
  Scenario: Attempt registration with an invalid email format
    When I fill "Username" with "{{random.username}}"
    And I fill "Email" with "{{negative.email}}"
    And I fill "Password" with "{{random.password}}"
    And I fill "Confirm Password" with "{{random.password}}"
    And I click the "Register" button
    Then I should see the text "Email is invalid"

  @TC-TC5
  Scenario: Attempt registration with mismatching passwords
    When I fill "Username" with "{{random.username}}"
    And I fill "Email" with "{{random.email}}"
    And I fill "Password" with "ValidPassword123!"
    And I fill "Confirm Password" with "DifferentPassword456!"
    And I click the "Register" button
    Then I should see the text "Passwords do not match"

  @TC-TC6
  Scenario: Attempt registration with an already registered username
    When I fill "Username" with the value of env "APP_USERNAME"
    And I fill "Email" with "{{random.email}}"
    And I fill "Password" with "{{random.password}}"
    And I fill "Confirm Password" with "{{random.password}}"
    And I click the "Register" button
    Then I should see the text "Username is already taken"

  @TC-TC7
  Scenario: Attempt registration with an already registered email address
    When I fill "Username" with "{{random.username}}"
    And I fill "Email" with the value of env "APP_USERNAME"
    And I fill "Password" with "{{random.password}}"
    And I fill "Confirm Password" with "{{random.password}}"
    And I click the "Register" button
    Then I should see the text "Email is already in use"

  @TC-TC8
  Scenario: Attempt registration with a password shorter than minimum length
    When I fill "Username" with "{{random.username}}"
    And I fill "Email" with "{{random.email}}"
    And I fill "Password" with "short"
    And I fill "Confirm Password" with "short"
    And I click the "Register" button
    Then I should see the text "Password must be at least 8 characters long"

  @TC-TC9
  Scenario: Attempt XSS injection in a text input field
    When I fill "Username" with "{{security.username}}"
    And I fill "Email" with "{{random.email}}"
    And I fill "Password" with "{{random.password}}"
    And I fill "Confirm Password" with "{{random.password}}"
    And I click the "Register" button
    Then no alert dialog should appear

  @TC-TC10
  Scenario: Verify password and confirm password fields are masked
    When I fill "Password" with "a-test-password"
    Then the "Password" field is masked
    When I fill "Confirm Password" with "a-test-password"
    Then the "Confirm Password" field is masked

  @TC-TC11
  Scenario: Navigate from registration page to login page via link
    When I click the "Login" link
    Then the URL should contain "login.html"
    And I should see the text "Login"

  @TC-TC12
  Scenario: Verify keyboard navigation through form fields using Tab key
    When I press the "Tab" key
    Then the focus is on the "Username" field
    When I press the "Tab" key
    Then the focus is on the "Email" field
    When I press the "Tab" key
    Then the focus is on the "Password" field
    When I press the "Tab" key
    Then the focus is on the "Confirm Password" field
    When I press the "Tab" key
    Then the focus is on the "Register" button
    When I press the "Tab" key
    Then the focus is on the "Login" link

  @TC-TC13
  Scenario: Verify form submission using the Enter key
    When I fill "Username" with "{{random.username}}"
    And I fill "Email" with "{{random.email}}"
    And I fill "Password" with "{{random.password}}"
    And I fill "Confirm Password" with "{{random.password}}"
    And I press the "Enter" key
    Then the URL should contain "confirmation"
    And I should see the text "Registration successful!"