import { Then } from '@cucumber/cucumber';
import { CustomWorld } from '../support/world.js';
import { expect } from '@playwright/test';

Then('the "{string}" field should be a password field', async function (this: CustomWorld, label: string) {
  const field = this.page.getByRole('textbox', { name: label, exact: true });
  await expect(field).toHaveAttribute('type', 'password');
});

Then('the "{string}" field should be focused', async function (this: CustomWorld, label: string) {
  const field = this.page.getByRole(['textbox', 'spinbutton', 'combobox', 'checkbox'], { name: label, exact: true });
  await expect(field).toBeFocused();
});

Then('the "{string}" button should be focused', async function (this: CustomWorld, name: string) {
  const button = this.page.getByRole('button', { name, exact: true });
  await expect(button).toBeFocused();
});
