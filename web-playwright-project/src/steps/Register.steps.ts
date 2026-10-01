import { Then } from '@cucumber/cucumber';
import { expect } from '@playwright/test';
import { CustomWorld } from '../support/world.js';
import { RegisterPage } from '../pages/RegisterPage.js';

Then('the {string} field should be masked', async function (this: CustomWorld, name: string) {
  const registerPage = new RegisterPage(this.page);
  let locator;
  switch (name) {
    case 'Account password':
      locator = registerPage.accountPassword;
      break;
    case 'Confirm password':
      locator = registerPage.confirmPassword;
      break;
    default:
      throw new Error(`'${name}' is not a password field that can be checked for masking`);
  }
  await expect(locator).toHaveAttribute('type', 'password');
});

Then('the {string} element should be focused', async function (this: CustomWorld, name: string) {
  const registerPage = new RegisterPage(this.page);
  let locator;
  switch (name) {
    case 'Given name':
      locator = registerPage.givenName;
      break;
    case 'Family name':
      locator = registerPage.familyName;
      break;
    case 'Email address':
      locator = registerPage.emailAddress;
      break;
    case 'Mobile number':
      locator = registerPage.mobileNumber;
      break;
    case 'Age (years)':
      locator = registerPage.age;
      break;
    case 'Gender identity':
      locator = registerPage.genderIdentity;
      break;
    case 'Account password':
      locator = registerPage.accountPassword;
      break;
    case 'Confirm password':
      locator = registerPage.confirmPassword;
      break;
    case 'I accept the terms and conditions':
      locator = registerPage.termsCheckbox;
      break;
    case 'Create account':
      locator = registerPage.createAccountButton;
      break;
    default:
      throw new Error(`Unknown element name for focus check: ${name}`);
  }
  await expect(locator).toBeFocused();
});
