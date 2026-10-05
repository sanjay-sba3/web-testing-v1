@TS-85
Feature: User registration and login

  @dryrun @TC-TC1
  Scenario: User completes registration with valid inputs and logs in
    Given I open the "http://localhost:3000/register" page
    When I fill "Email" with "{{random.email}}"
    And I fill "First name" with "{{random.firstName}}"
    And I fill "Last name" with "{{random.lastName}}"
    And I fill "Account password" with "Secret123"
    And I fill "Confirm password" with "Secret123"
    And I check "I accept the terms and conditions"
    And I press the "Enter" key
    Then I should see the text "Registration successful"
    And I click the "Sign in" button
    And I fill "Email" with "{{random.email}}"
    And I fill "Password" with "${APP_PASSWORD}"
    And I press the "Enter" key
    Then the URL should contain "/dashboard"

  @TC-TC2
  Scenario: User submits registration with empty email field
    Given I open the "http://localhost:3000/register" page
    And I fill "First name" with "{{random.firstName}}"
    And I fill "Last name" with "{{random.lastName}}"
    And I fill "Account password" with "Secret123"
    And I fill "Confirm password" with "Secret123"
    And I check "I accept the terms and conditions"
    And I press the "Enter" key
    Then the "Email" field should be invalid
    And I should not see the text "Registration successful"

  @TC-TC3
  Scenario: User enters invalid email format in registration
    Given I open the "http://localhost:3000/register" page
    And I fill "Email" with "{{negative.email}}"
    And I fill "First name" with "{{random.firstName}}"
    And I fill "Last name" with "{{random.lastName}}"
    And I fill "Account password" with "Secret123"
    And I fill "Confirm password" with "Secret123"
    And I check "I accept the terms and conditions"
    And I press the "Enter" key
    Then the "Email" field should be invalid

  @TC-TC4
  Scenario: User enters script tag in name field during registration
    Given I open the "http://localhost:3000/register" page
    And I fill "First name" with "{{security.comment}}"
    And I fill "Email" with "{{random.email}}"
    And I fill "Account password" with "Secret123"
    And I fill "Confirm password" with "Secret123"
    And I check "I accept the terms and conditions"
    And I press the "Enter" key
    Then the "First name" field should be invalid
    And I should see the text "{{security.comment}}"

  @TC-TC5
  Scenario: Unauthenticated user navigates to dashboard URL
    Given I open the "http://localhost:3000/dashboard" page
    Then the URL should contain "/login"
    Then I should see the text "Please log in"

  @TC-TC6
  Scenario: User clicks Login on registration page and logs in
    Given I open the "http://localhost:3000/register" page
    And I click the "Sign in" button
    And I fill "Email" with "${APP_USERNAME}"
    And I fill "Password" with "${APP_PASSWORD}"
    And I press the "Enter" key
    Then the URL should contain "/dashboard"

  @TC-TC7
  Scenario: All registration form fields have labels and are keyboard accessible
    Given I open the "http://localhost:3000/register" page
    And I should see the text "Email"
    And I should see the text "First name"
    And I should see the text "Last name"
    And I should see the text "Account password"
    And I should see the text "Confirm password"
    And I press the "Tab" key
    And I press the "Enter" key
    Then the form should be submitted successfully