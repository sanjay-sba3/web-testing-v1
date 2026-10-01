import { Then } from '@cucumber/cucumber';
import type { DataTable } from '@cucumber/cucumber';
import { expect } from '@playwright/test';
import type { CustomWorld } from '../support/world.js';
import { RegisterPage } from '../pages/RegisterPage.js';

Then('I should see the following elements:', async function (this: CustomWorld, dataTable: DataTable) {
  const registerPage = new RegisterPage(this.page);
  const elementNames = dataTable.raw().slice(1).map(row => row[0]);
  for (const name of elementNames) {
    await expect(registerPage.getElementByName(name)).toBeVisible();
  }
});

Then('the {string} element should be a password field', async function (this: CustomWorld, name: string) {
  const registerPage = new RegisterPage(this.page);
  const element = registerPage.getElementByName(name);
  await expect(element).toHaveAttribute('type', 'password');
});

Then('the element with accessible name {string} should be focused', async function (this: CustomWorld, name: string) {
  const registerPage = new RegisterPage(this.page);
  const element = registerPage.getElementByName(name);
  await expect(element).toBeFocused();
});
