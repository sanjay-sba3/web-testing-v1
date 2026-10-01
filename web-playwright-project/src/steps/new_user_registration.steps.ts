import { Then } from '@cucumber/cucumber';
import { expect } from '@playwright/test';
import { CustomWorld } from '../support/world.js';
import { RegistrationPage } from '../pages/RegistrationPage.js';

Then('I should see the {string} heading', async function (this: CustomWorld, name: string) {
  const registrationPage = new RegistrationPage(this.page);
  await expect(registrationPage.getHeading(name)).toBeVisible();
});

Then('I should see the {string} field', async function (this: CustomWorld, label: string) {
  const el = this.page.getByRole(['textbox', 'spinbutton', 'combobox', 'checkbox'], { name: label, exact: true });
  await expect(el).toBeVisible();
});

Then('the {string} field should be a password field', async function (this: CustomWorld, label: string) {
  const el = this.page.getByRole('textbox', { name: label, exact: true });
  await expect(el).toHaveAttribute('type', 'password');
});

Then('the {string} field should be focused', async function (this: CustomWorld, label: string) {
  const el = this.page.getByRole(['textbox', 'spinbutton', 'combobox', 'checkbox'], { name: label, exact: true });
  await expect(el).toBeFocused();
});

Then('the {string} button should be focused', async function (this: CustomWorld, name: string) {
  const el = this.page.getByRole('button', { name, exact: true });
  await expect(el).toBeFocused();
});
