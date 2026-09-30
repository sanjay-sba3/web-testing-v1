import { Given, When, Then } from '@cucumber/cucumber';
import { expect } from '@playwright/test';
import { CustomWorld } from '../support/world.js';
import { LoginPage } from '../pages/LoginPage.js';
import { DashboardPage } from '../pages/DashboardPage.js';

Then('I should see the {string} input field', async function (this: CustomWorld, label: string) {
  const loginPage = new LoginPage(this.page);
  if (label === 'Email') {
    await expect(loginPage.emailInput).toBeVisible();
  } else if (label === 'Password') {
    await expect(loginPage.passwordInput).toBeVisible();
  } else {
    throw new Error(`Input field with label "${label}" not defined in this step.`);
  }
});

Then('the {string} input field should be masked', async function (this: CustomWorld, label: string) {
  const loginPage = new LoginPage(this.page);
  await expect(loginPage.passwordInput).toHaveAttribute('type', 'password');
});

Given('I am logged in', async function (this: CustomWorld) {
  const loginPage = new LoginPage(this.page);
  await this.page.goto('http://localhost:8080/login.html');
  const username = process.env.APP_USERNAME;
  const password = process.env.APP_PASSWORD;
  if (!username || !password) {
    throw new Error('APP_USERNAME and APP_PASSWORD environment variables must be set.');
  }
  await loginPage.login(username, password);
  await this.page.waitForURL('**/dashboard**');
  await expect(this.page).toHaveURL(/.*\/dashboard/);
});

When('I press the {string} key', async function (this: CustomWorld, key: string) {
  await this.page.keyboard.press(key);
});

Then('the {string} input field should have focus', async function (this: CustomWorld, label: string) {
  const loginPage = new LoginPage(this.page);
  if (label === 'Email') {
    await expect(loginPage.emailInput).toBeFocused();
  } else if (label === 'Password') {
    await expect(loginPage.passwordInput).toBeFocused();
  } else {
    throw new Error(`Input field with label "${label}" not defined in this step.`);
  }
});

Then('the {string} button should have focus', async function (this: CustomWorld, name: string) {
  const loginPage = new LoginPage(this.page);
  if (name === 'Sign in') {
    await expect(loginPage.signInButton).toBeFocused();
  } else {
    throw new Error(`Button with name "${name}" not defined in this step.`);
  }
});
