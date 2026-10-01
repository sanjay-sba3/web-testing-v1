import { Then } from '@cucumber/cucumber';
import { expect } from '@playwright/test';
import { CustomWorld } from '../support/world.js';
import { RegisterPage } from '../pages/RegisterPage.js';

Then('the {string} field should be masked', async function (this: CustomWorld, label: string) {
  const registerPage = new RegisterPage(this.page);
  const field = registerPage.getLocatorByLabel(label);
  await expect(field).toHaveAttribute('type', 'password');
});

Then('the {string} field should be focused', async function (this: CustomWorld, label: string) {
  const registerPage = new RegisterPage(this.page);
  const field = registerPage.getLocatorByLabel(label);
  await expect(field).toBeFocused();
});

Then('the {string} button should be focused', async function (this: CustomWorld, label: string) {
  const registerPage = new RegisterPage(this.page);
  const field = registerPage.getLocatorByLabel(label);
  await expect(field).toBeFocused();
});
