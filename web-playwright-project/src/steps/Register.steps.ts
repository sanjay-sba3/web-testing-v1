import { Then } from '@cucumber/cucumber';
import { expect } from '@playwright/test';
import { CustomWorld } from '../support/world.js';
import { RegisterPage } from '../pages/RegisterPage.js';

Then('the {string} field should be a password field', async function (this: CustomWorld, label: string) {
  const registerPage = new RegisterPage(this.page);
  let locator;
  switch (label) {
    case 'Password':
      locator = registerPage.password;
      break;
    case 'Confirm password':
      locator = registerPage.confirmPassword;
      break;
    default:
      throw new Error(`Field "${label}" is not a known password field.`);
  }
  await expect(locator).toHaveAttribute('type', 'password');
});

Then('the {string} field should have focus', async function (this: CustomWorld, label: string) {
  const registerPage = new RegisterPage(this.page);
  const locators: { [key: string]: any } = {
    'First name': registerPage.firstName,
    'Last name': registerPage.lastName,
    'Email': registerPage.email,
    'Phone': registerPage.phone,
    'Age': registerPage.age,
    'Gender': registerPage.gender,
    'Password': registerPage.password,
    'Confirm password': registerPage.confirmPassword,
    'I accept the terms': registerPage.acceptTerms,
  };
  const locator = locators[label];
  if (!locator) {
    throw new Error(`Could not find a field locator for label: "${label}"`);
  }
  await expect(locator).toBeFocused();
});

Then('the {string} button should have focus', async function (this: CustomWorld, name: string) {
  const registerPage = new RegisterPage(this.page);
  const locators: { [key: string]: any } = {
    'Create account': registerPage.createAccount,
  };
  const locator = locators[name];
  if (!locator) {
    throw new Error(`Could not find a button locator for name: "${name}"`);
  }
  await expect(locator).toBeFocused();
});
