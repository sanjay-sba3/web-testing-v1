import { Then } from '@cucumber/cucumber';
import { expect } from '@playwright/test';
import { CustomWorld } from '../support/world.js';
import { RegisterPage } from '../pages/RegisterPage.js';

const getElementLocator = (page: RegisterPage, elementName: string) => {
  const elementMap: { [key: string]: any } = {
    'First name': page.firstName,
    'Last name': page.lastName,
    'Email': page.email,
    'Password': page.password,
    'Confirm password': page.confirmPassword,
    'Create account': page.createAccountButton,
    'Login': page.loginLink,
  };
  const locator = elementMap[elementName];
  if (!locator) {
    throw new Error(`Element locator for "${elementName}" not found on RegisterPage`);
  }
  return locator;
};

Then('I should see the {string} field', async function (this: CustomWorld, fieldName: string) {
  const registerPage = new RegisterPage(this.page);
  const locator = getElementLocator(registerPage, fieldName);
  await expect(locator).toBeVisible();
});

Then('I should see the {string} link', async function (this: CustomWorld, linkName: string) {
  const registerPage = new RegisterPage(this.page);
  const locator = getElementLocator(registerPage, linkName);
  await expect(locator).toBeVisible();
});

Then('the {string} field\'s input should be masked', async function (this: CustomWorld, fieldName: string) {
  const registerPage = new RegisterPage(this.page);
  const locator = getElementLocator(registerPage, fieldName);
  await expect(locator).toHaveAttribute('type', 'password');
});

Then('the value of the {string} field should be {string}', async function (this: CustomWorld, fieldName: string, expectedValue: string) {
  const registerPage = new RegisterPage(this.page);
  const locator = getElementLocator(registerPage, fieldName);
  await expect(locator).toHaveValue(expectedValue);
});

Then('the {string} element should have focus', async function (this: CustomWorld, elementName: string) {
  const registerPage = new RegisterPage(this.page);
  const locator = getElementLocator(registerPage, elementName);
  await expect(locator).toBeFocused();
});
