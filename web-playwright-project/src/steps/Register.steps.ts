import { Before, Then } from '@cucumber/cucumber';
import { expect } from '@playwright/test';
import { CustomWorld } from '../support/world.js';
import { loadTestData } from '../support/testData.js';
import { resolveTokens } from '../support/testDataGenerator.js';

Before({ tags: '@TS-63' }, async function (this: CustomWorld) {
  this.testData = await loadTestData('Register');
});

Then('the value of the {string} field should be {string}', async function (this: CustomWorld, label: string, expectedValue: string) {
  const resolvedValue = await resolveTokens(expectedValue, this.testData);
  const field = this.page.getByRole('textbox', { name: label, exact: true });
  await expect(field).toHaveValue(resolvedValue);
});

Then('the {string} field should be masked', async function (this: CustomWorld, label: string) {
  const field = this.page.getByRole('textbox', { name: label, exact: true });
  await expect(field).toHaveAttribute('type', 'password');
});
