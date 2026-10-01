import { DataTable, Then, When } from '@cucumber/cucumber';
import { expect } from '@playwright/test';
import { CustomWorld } from '../support/world.js';
import { RegisterPage } from '../pages/RegisterPage.js';
import { resolveTokens } from '../support/testDataGenerator.js';

Then('I should see the following elements:', async function (this: CustomWorld, dataTable: DataTable) {
  const registerPage = new RegisterPage(this.page);
  const rows = dataTable.hashes();
  for (const row of rows) {
    const { name, type } = row;
    const element = registerPage.getElement(name, type);
    await expect(element, `Expected to see ${type} "${name}"`).toBeVisible();
  }
});

Then('the {string} field should have the value {string}', async function (this: CustomWorld, label: string, value: string) {
  const registerPage = new RegisterPage(this.page);
  const resolvedValue = resolveTokens(value);
  const field = registerPage.getFieldByLabel(label);
  await expect(field).toHaveValue(resolvedValue);
});

Then('the {string} field should be masked', async function (this: CustomWorld, label: string) {
  const registerPage = new RegisterPage(this.page);
  const field = registerPage.getFieldByLabel(label);
  await expect(field).toHaveAttribute('type', 'password');
});

Then('the {string} field should have focus', async function (this: CustomWorld, label: string) {
  const registerPage = new RegisterPage(this.page);
  const field = registerPage.getFieldByLabel(label);
  await expect(field).toBeFocused();
});

Then('the {string} button should have focus', async function (this: CustomWorld, name: string) {
  const registerPage = new RegisterPage(this.page);
  const button = registerPage.getElement(name, 'button');
  await expect(button).toBeFocused();
});
