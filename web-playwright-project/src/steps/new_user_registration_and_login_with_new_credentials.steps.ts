import { When, Then } from '@cucumber/cucumber';
import { CustomWorld } from '../support/world.js';
import { expect } from '@playwright/test';

When('I am logged in', async function(this: CustomWorld) {
  // This step would need implementation based on application specifics
});

Then('the {string} field should mask the input', async function(this: CustomWorld, label: string) {
  const field = this.page.getByRole('textbox', { name: label, exact: true });
  const type = await field.getAttribute('type');
  expect(type).toBe('password');
});

Then('the {string} field should be focused', async function(this: CustomWorld, label: string) {
  const field = this.page.getByRole('textbox', { name: label, exact: true });
  await expect(field).toBeFocused();
});

Then('the {string} button should be focused', async function(this: CustomWorld, label: string) {
  const button = this.page.getByRole('button', { name: label, exact: true });
  await expect(button).toBeFocused();
});