import { Given, When, Then } from '@cucumber/cucumber';
import { expect } from '@playwright/test';
import { CustomWorld } from '../support/world.js';
import { LoginPage } from '../pages/LoginPage.js';
import { loadTestData } from '../support/testData.js';

// This is here to satisfy the framework requirement, though not used in these specific steps.
const testDataPromise = loadTestData('login');

Then('the {string} field should be visible', async function (this: CustomWorld, fieldLabel: string) {
  const loginPage = new LoginPage(this.page);
  let locator;
  switch (fieldLabel) {
    case 'Email':
      locator = loginPage.email;
      break;
    case 'Password':
      locator = loginPage.password;
      break;
    default:
      throw new Error(`Field with label "${fieldLabel}" is not defined on the Login page object.`);
  }
  await expect(locator).toBeVisible();
});

Then('the {string} field should be masked', async function (this: CustomWorld, fieldLabel: string) {
  const loginPage = new LoginPage(this.page);
  if (fieldLabel === 'Password') {
    await expect(loginPage.password).toHaveAttribute('type', 'password');
  } else {
    throw new Error(`Masking check for field "${fieldLabel}" is not implemented.`);
  }
});

Given('I am not logged in', async function (this: CustomWorld) {
  await this.context.clearCookies();
  // Using evaluate to clear sessionStorage as it's not directly accessible
  await this.page.evaluate(() => window.sessionStorage.clear());
});
