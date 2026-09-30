@TS-50
Feature: Login Functionality

  @dryrun @TC-TC1
  Scenario: Successful login with valid credentials
    Given I open the "http://localhost:8080/login.html" page
    When I fill "Email" with the value of env "APP_USERNAME"
    And I fill "Password" with the value of env "APP_PASSWORD"
    And I click the "Sign in" button
    Then the URL should contain "/dashboard"
    And I should see the text "Welcome"

  @TC-TC2 @TC-TC3 @TC-TC10
  Scenario Outline: Login attempt with invalid or malicious credentials
    Given I open the "http://localhost:8080/login.html" page
    When I fill "Email" with "<username>"
    And I fill "Password" with "<password>"
    And I click the "Sign in" button
    Then I should see the text "Invalid credentials"
    And the URL should contain "/login.html"
    Examples:
      | username                        | password          |
      | ${APP_USERNAME}                 | wrongpassword123  |
      | nonexistentuser                 | anypassword       |
      | <script>alert('XSS')</script>   | anypassword       |

  @TC-TC4
  Scenario: Login attempt with empty username field
    Given I open the "http://localhost:8080/login.html" page
    When I fill "Password" with the value of env "APP_PASSWORD"
    And I click the "Sign in" button
    Then I should see the text "Username is required"

  @TC-TC5
  Scenario: Login attempt with empty password field
    Given I open the "http://localhost:8080/login.html" page
    When I fill "Email" with the value of env "APP_USERNAME"
    And I click the "Sign in" button
    Then I should see the text "Password is required"

  @TC-TC6
  Scenario: Verify login page UI elements are visible
    Given I open the "http://localhost:8080/login.html" page
    Then I should see the "Email" input field
    And I should see the "Password" input field
    And I should see the "Sign in" button

  @TC-TC7
  Scenario: Verify password input is masked
    Given I open the "http://localhost:8080/login.html" page
    When I fill "Password" with "testpassword"
    Then the "Password" input field should be masked

  @TC-TC8
  Scenario: Successful logout from the dashboard
    Given I am logged in
    When I click the "Logout" button
    Then the URL should contain "/login.html"

  @TC-TC9
  Scenario: Accessing a protected page while unauthenticated
    Given I open the "http://localhost:8080/dashboard.html" page
    Then the URL should contain "/login.html"

  @TC-TC11
  Scenario: Successful login using only keyboard
    Given I open the "http://localhost:8080/login.html" page
    Then the "Email" input field should have focus
    When I fill "Email" with the value of env "APP_USERNAME"
    And I press the "Tab" key
    Then the "Password" input field should have focus
    When I fill "Password" with the value of env "APP_PASSWORD"
    And I press the "Tab" key
    Then the "Sign in" button should have focus
    When I press the "Enter" key
    Then the URL should contain "/dashboard"
