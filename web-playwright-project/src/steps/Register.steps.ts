import { When, Then, Before } from '@cucumber/cucumber';
import { expect } from '@playwright/test';
import { CustomWorld } from '../support/world.js';
import { RegisterPage } from '../pages/RegisterPage.js';

let dialogError: Error | null = null;

Before({ tags: '@TC-TC9' }, function (this: CustomWorld) {
  dialogError = null;
  this.page.once('dialog', (dialog) => {
    dialogError = new Error(`Unexpected dialog appeared: [${dialog.type()}] ${dialog.message()}`);
    dialog.dismiss().catch(() => {});
  });
});

Then('I should see the {string} input field', async function (this: CustomWorld, label: string) {
  // TODO: Locator inferred, not from a captured DOM snapshot for the register page.
  await expect(this.page.getByLabel(label)).toBeVisible();
});

Then('no alert dialog should appear', async function () {
  // This step relies on the Before hook tagged for @TC-TC9.
  // It will throw an error if a dialog was detected during the scenario execution.
  if (dialogError) {
    throw dialogError;
  }
});

Then('the {string} field is masked', async function (this: CustomWorld, label: 'Password' | 'Confirm Password') {
  const registerPage = new RegisterPage(this.page);
  const field = label === 'Password' ? registerPage.passwordInput : registerPage.confirmPasswordInput;
  await expect(field).toHaveAttribute('type', 'password');
});

When('I press the {string} key', async function (this: CustomWorld, key: string) {
  await this.page.keyboard.press(key);
});

Then('the focus is on the {string} field', async function (this: CustomWorld, label: string) {
  // TODO: Locator inferred, not from a captured DOM snapshot for the register page.
  await expect(this.page.getByLabel(label)).toBeFocused();
});

Then('the focus is on the {string} button', async function (this: CustomWorld, name: string) {
  // TODO: Locator inferred, not from a captured DOM snapshot for the register page.
  await expect(this.page.getByRole('button', { name })).toBeFocused();
});

Then('the focus is on the {string} link', async function (this: CustomWorld, name: string) {
  // TODO: Locator inferred, not from a captured DOM snapshot for the register page.
  await expect(this.page.getByRole('link', { name })).toBeFocused();
});
