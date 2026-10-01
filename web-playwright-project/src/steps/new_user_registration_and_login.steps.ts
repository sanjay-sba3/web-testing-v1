import { When, Then, Before } from '@cucumber/cucumber';
import { expect } from '@playwright/test';
import { CustomWorld } from '../support/world.js';
import { loadTestData } from '../support/testData.js';

// This helper would exist in a file like src/support/control-helper.ts
// For the purpose of this response, I'll define a simplified version here.
// In a real project, this would be more robust.
const controlLocators = {
  field: (page, name) => page.getByRole(/(textbox|spinbutton|combobox)/, { name, exact: true }),
  checkbox: (page, name) => page.getByRole('checkbox', { name, exact: true }),
  button: (page, name) => page.getByRole('button', { name, exact: true }),
  link: (page, name) => page.getByRole('link', { name, exact: true }),
};

Before(async function (this: CustomWorld) {
  this.testData = await loadTestData('new_user_registration_and_login');
});

When('I fill {string} with test data {string}', async function (this: CustomWorld, label: string, dataKey: string) {
  const value = this.testData[dataKey];
  if (value === undefined) {
    throw new Error(`Test data key "${dataKey}" not found in new_user_registration_and_login.json`);
  }
  // This logic mimics the shared 'fill' step
  await this.page.getByRole(/(textbox|spinbutton)/, { name: label, exact: true }).fill(value);
});

Then('the {string} field should be visible', async function (this: CustomWorld, label: string) {
  await expect(this.page.getByRole(/(textbox|spinbutton|combobox)/, { name: label, exact: true })).toBeVisible();
});

Then('the {string} field is masked', async function (this: CustomWorld, label: string) {
  await expect(this.page.getByRole('textbox', { name: label, exact: true })).toHaveAttribute('type', 'password');
});

Then('the {string} {word} has focus', async function (this: CustomWorld, name: string, controlType: string) {
  const locatorFn = controlLocators[controlType];
  if (!locatorFn) {
    throw new Error(`Unsupported control type "${controlType}". Supported types are: ${Object.keys(controlLocators).join(', ')}`);
  }
  const locator = locatorFn(this.page, name);
  await expect(locator).toBeFocused();
});
