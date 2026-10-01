import { Given, When, Then } from '@cucumber/cucumber';
import { expect } from '@playwright/test';
import { CustomWorld } from '../support/world.js';
import { loadTestData } from '../support/testData.js';
import { generateValue } from '../support/testDataGenerator.js';
import { LoginPage } from '../pages/LoginPage.js';
import { RegisterPage } from '../pages/RegisterPage.js';

Given('I load the test data for {string}', async function (this: CustomWorld, testDataFile: string) {
  this.testData = await loadTestData(testDataFile);
});

When('I fill {string} with a value from test data {string}', async function (this: CustomWorld, label: string, key: string) {
  const value = this.testData[key];
  if (value === undefined) {
    throw new Error(`Test data key "${key}" not found.`);
  }
  const field = this.page.getByRole(/textbox|spinbutton/, { name: label, exact: true });
  await field.fill(value);
});

When('I successfully register a new user', async function (this: CustomWorld) {
  const registerPage = new RegisterPage(this.page);
  this.sharedData = this.sharedData || {};
  this.sharedData.email = generateValue('email', 'random');
  this.sharedData.password = this.testData.validPassword;

  await registerPage.register(
    'Test',
    'User',
    this.sharedData.email,
    '30',
    'Male',
    this.sharedData.password
  );
});

When('I login with the new user\'s credentials', async function (this: CustomWorld) {
  const loginPage = new LoginPage(this.page);
  if (!this.sharedData?.email || !this.sharedData?.password) {
    throw new Error('User credentials not found in shared context. Was a user registered in a previous step?');
  }
  await loginPage.login(this.sharedData.email, this.sharedData.password);
});

Then('the {string} field should be masked', async function (this: CustomWorld, label: string) {
  const field = this.page.getByRole('textbox', { name: label, exact: true });
  await expect(field).toHaveAttribute('type', 'password');
});

Then('the {string} button has focus', async function (this: CustomWorld, name: string) {
  const button = this.page.getByRole('button', { name, exact: true });
  await expect(button).toBeFocused();
});

Then('the {string} field has focus', async function (this: CustomWorld, name: string) {
  const field = this.page.getByRole(/textbox|spinbutton|combobox|checkbox/, { name, exact: true });
  await expect(field).toBeFocused();
});
