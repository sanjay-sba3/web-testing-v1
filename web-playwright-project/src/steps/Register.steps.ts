import { Before, Then } from '@cucumber/cucumber';
import { expect } from '@playwright/test';
import { CustomWorld } from '../support/world.js';
import { RegisterPage } from '../pages/RegisterPage.js';
import { loadTestData } from '../support/testData.js';

// Load test data for the feature, as per framework guidelines
Before(async function () {
  await loadTestData('Register');
});

Then('the {string} field should be masked', async function (this: CustomWorld, label: string) {
  const registerPage = new RegisterPage(this.page);
  const locator = registerPage.getLocatorByLabel(label);
  await expect(locator).toHaveAttribute('type', 'password');
});

Then('the {string} field should be focused', async function (this: CustomWorld, label: string) {
  const registerPage = new RegisterPage(this.page);
  const locator = registerPage.getLocatorByLabel(label);
  await expect(locator).toBeFocused();
});
