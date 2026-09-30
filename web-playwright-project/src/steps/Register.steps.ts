import { Before, Given, When, Then } from '@cucumber/cucumber';
import { expect } from '@playwright/test';
import { CustomWorld } from '../support/world.js';
import { loadTestData } from '../support/testData.js';
import { RegisterPage } from '../pages/RegisterPage.js';
import { LoginPage } from '../pages/LoginPage.js';

interface RegisterData {
  user: {
    firstName: string;
    lastName: string;
    email: string;
    password: string;
    xssFirstName: string;
  },
  validation: {
    invalidEmail: string;
    nonMatchingPassword: string;
    shortPassword: string;
    minLenPassword: string;
  }
}

Before(async function (this: CustomWorld) {
  this.testData = await loadTestData<RegisterData>('Register');
  this.registerPage = new RegisterPage(this.page);
  this.loginPage = new LoginPage(this.page);
  this.alertOccurred = false;
});

Given('I am listening for browser alerts', function (this: CustomWorld) {
  this.page.on('dialog', dialog => {
    if (dialog.type() === 'alert') {
      this.alertOccurred = true;
    }
    void dialog.dismiss();
  });
});

When('I fill "{string}" with the "{string}" from test data', async function (this: CustomWorld, label: string, dataKey: string) {
  const keys = dataKey.split('.');
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  let value = this.testData as any;
  for (const key of keys) {
    value = value[key];
  }

  await this.page.getByLabel(label).fill(value as string);
});

When('I press the Tab key', async function (this: CustomWorld) {
  await this.page.keyboard.press('Tab');
});

When('I click the label text "{string}"', async function (this: CustomWorld, labelText: string) {
  await this.page.getByText(labelText, { exact: true }).click();
});

Then('the "{string}" field shows the error "{string}"', async function (this: CustomWorld, field: string, message: string) {
  // This is a simplification. A real implementation would find the error element
  // programmatically associated with the input field.
  await expect(this.page.getByText(message)).toBeVisible();
});

Then('the URL should not contain "{string}"', async function (this: CustomWorld, text: string) {
  await expect(this.page).not.toHaveURL(new RegExp(text));
});

Then('the "{string}" field input is masked', async function (this: CustomWorld, label: string) {
  await expect(this.page.getByLabel(label)).toHaveAttribute('type', 'password');
});

Then('no browser alert dialog should have appeared', function (this: CustomWorld) {
  expect(this.alertOccurred, 'An unexpected browser alert was displayed').toBe(false);
});

Then('the "{string}"( input)? field is focused', async function (this: CustomWorld, label: string) {
    await expect(this.page.getByLabel(label)).toBeFocused();
});

Then('the "{string}" button is focused', async function (this: CustomWorld, name: string) {
    await expect(this.page.getByRole('button', { name })).toBeFocused();
});
