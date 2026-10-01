@TS-63
Feature: User Registration

  Background:
    Given I open the "http://localhost:8080/register.html" page

  # needs-review: No snapshot provided for register.html. Assuming accessible names from test case.
  @needs-review @TC-TC1
  Scenario: Successful registration with all valid data
    When I fill "Email" with "{{random.email}}"
    And I fill "Password" with "ValidPassword123!"
    And I fill "Confirm Password" with "ValidPassword123!"
    And I fill "First Name" with "John"
    And I fill "Last Name" with "Doe"
    And I click the "Register" button
    Then the URL should contain "/login"

  # needs-review: No snapshot provided for register.html. Assuming accessible names and link text "Have an account?".
  @needs-review @TC-TC2
  Scenario: Verify registration page UI elements are displayed
    Then I should see the following elements:
      | name               | type   |
      | First Name         | field  |
      | Last Name          | field  |
      | Email              | field  |
      | Password           | field  |
      | Confirm Password   | field  |
      | Register           | button |
      | Have an account?   | link   |

  # needs-review: No snapshot provided for register.html. Assuming accessible names from test case.
  @needs-review @TC-TC3
  Scenario: Attempt registration with all required fields empty
    When I click the "Register" button
    Then the "Email" field should be invalid
    And the "Password" field should be invalid
    And the "Confirm Password" field should be invalid
    And the "First Name" field should be invalid
    And the "Last Name" field should be invalid

  # needs-review: No snapshot provided for register.html. Assuming accessible names from test case.
  @needs-review @TC-TC4
  Scenario: Attempt registration with an invalid email format
    When I fill "Email" with "{{negative.email}}"
    And I fill "Password" with "ValidPassword123!"
    And I fill "Confirm Password" with "ValidPassword123!"
    And I fill "First Name" with "Jane"
    And I fill "Last Name" with "Doe"
    And I click the "Register" button
    Then the "Email" field should be invalid

  # needs-review: No snapshot provided for register.html. Assuming accessible names from test case and browser validation on mismatch.
  @needs-review @TC-TC5
  Scenario: Attempt registration with mismatching passwords
    When I fill "Email" with "{{random.email}}"
    And I fill "Password" with "PasswordA123!"
    And I fill "Confirm Password" with "PasswordB456!"
    And I fill "First Name" with "Alex"
    And I fill "Last Name" with "Smith"
    And I click the "Register" button
    Then the "Confirm Password" field should be invalid

  # needs-review: No snapshot provided for register.html. Assuming minlength validation on Password field.
  @needs-review @TC-TC6
  Scenario: Attempt registration with a password shorter than minimum length
    When I fill "Email" with "{{random.email}}"
    And I fill "Password" with "short"
    And I fill "Confirm Password" with "short"
    And I fill "First Name" with "Chris"
    And I fill "Last Name" with "Green"
    And I click the "Register" button
    Then the "Password" field should be invalid

  # needs-review: No snapshot provided for register.html. Assuming link text is "Have an account?".
  @needs-review @TC-TC7
  Scenario: Navigate from registration to login page via link
    When I click the "Have an account?" link
    Then the URL should contain "/login"

  # needs-review: No snapshot provided for register.html. Assuming accessible names from test case.
  @needs-review @TC-TC8
  Scenario: Verify XSS protection on form input fields
    When I fill "Password" with "ValidPassword123!"
    And I fill "Confirm Password" with "ValidPassword123!"
    And I fill "First Name" with "{{security.comment}}"
    And I fill "Last Name" with "Secure"
    And I click the "Register" button
    Then the "Email" field should be invalid
    And the "First Name" field should have the value "<script>alert(1)</script>"

  # needs-review: No snapshot provided for register.html. Assuming standard password input types.
  @needs-review @TC-TC9
  Scenario Outline: Verify password fields are masked
    When I fill "<Field>" with "MySecretPassword123"
    Then the "<Field>" field should be masked

    Examples:
      | Field            |
      | Password         |
      | Confirm Password |

  # needs-review: No snapshot provided for register.html. Assuming field focus order.
  @needs-review @TC-TC10
  Scenario: Navigate and submit form using only the keyboard
    # The first Tab press is assumed to focus the first field in the form
    When I press the "Tab" key
    Then the "Email" field should have focus
    When I fill "Email" with "{{random.email}}"
    When I press the "Tab" key
    Then the "Password" field should have focus
    When I fill "Password" with "KeyboardUserPass1!"
    When I press the "Tab" key
    Then the "Confirm Password" field should have focus
    When I fill "Confirm Password" with "KeyboardUserPass1!"
    When I press the "Tab" key
    Then the "First Name" field should have focus
    When I fill "First Name" with "Keyboard"
    When I press the "Tab" key
    Then the "Last Name" field should have focus
    When I fill "Last Name" with "User"
    When I press the "Tab" key
    Then the "Register" button should have focus
    When I press the "Enter" key
    Then the URL should contain "/login"
