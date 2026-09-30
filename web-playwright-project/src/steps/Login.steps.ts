import { Before, When, Then } from '@cucumber/cucumber';
import { expect } from '@playwright/test';
import { CustomWorld } from '../support/world.js';
import { loadTestData } from '../support/testData.js';
import { LoginPage } from '../pages/LoginPage.js';
import { DashboardPage } from '../pages/DashboardPage.js';

// Test Data Type
interface LoginData {
  validUser: { email: string; password: string };
}

// Module-level flag for XSS test
let dialogFired = false;

When('I login with valid credentials', async function (this: CustomWorld) {
  const loginPage = new LoginPage(this.page);
  const testData = await loadTestData<LoginData>('Login');
  await loginPage.login(testData.validUser.email, testData.validUser.password);
});

Then('I should see the "{string}" field', async function (this: CustomWorld, label: string) {
  await expect(this.page.getByLabel(label)).toBeVisible();
});

When('I press the "{string}" key', async function (this: CustomWorld, key: string) {
  await this.page.keyboard.press(key);
});

// Hooks and steps for XSS check (TC-TC8)
Before({ tags: '@TC-TC8' }, async function (this: CustomWorld) {
  dialogFired = false;
  this.page.once('dialog', (dialog) => {
    dialogFired = true;
    dialog.dismiss().catch(() => {});
  });
});

Then('no javascript alert should have appeared', async function () {
  expect(dialogFired, 'A javascript alert appeared when it should not have.').toBe(false);
});
