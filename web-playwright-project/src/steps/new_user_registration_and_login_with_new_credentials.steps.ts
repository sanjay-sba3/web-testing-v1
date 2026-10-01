import { Given, When, Then, BeforeAll } from '@cucumber/cucumber';
import { expect } from '@playwright/test';
import { CustomWorld } from '../support/world.js';
import { generateValue } from '../support/testDataGenerator.js';
import { loadTestData } from '../support/testData.js';
import { LoginPage } from '../pages/LoginPage.js';
import { RegisterPage } from '../pages/RegisterPage.js';

let testData: any;

BeforeAll(async () => {
  testData = await loadTestData('new_user_registration_and_login_with_new_credentials');
});

type JourneyWorld = CustomWorld & { email?: string; password?: string };

Given('I have a browser context', async function (this: CustomWorld) {
  // This step is mainly for readability and to ensure the context is ready.
  // The actual context is created by hooks.ts before each scenario.
});

Then('I should see all required elements on the registration page', async function (this: CustomWorld) {
  const registerPage = new RegisterPage(this.page);
  await expect(registerPage.givenName).toBeVisible();
  await expect(registerPage.familyName).toBeVisible();
  await expect(registerPage.emailAddress).toBeVisible();
  await expect(registerPage.accountPassword).toBeVisible();
  await expect(registerPage.confirmPassword).toBeVisible();
  await expect(registerPage.createAccountButton).toBeVisible();
});

Then('I should see all required elements on the login page', async function (this: CustomWorld) {
  const loginPage = new LoginPage(this.page);
  await expect(loginPage.email).toBeVisible();
  await expect(loginPage.password).toBeVisible();
  await expect(loginPage.signInButton).toBeVisible();
});

Given('I register a new user', async function (this: JourneyWorld) {
  const registerPage = new RegisterPage(this.page);
  this.email = generateValue('email');
  this.password = testData.validPassword;
  await registerPage.open();
  await registerPage.register(
    generateValue('firstName'),
    generateValue('lastName'),
    this.email,
    '28',
    'Male',
    this.password,
    true
  );
  await expect(this.page).toHaveURL(/.*\/login/);
});

When('I attempt to register with the same email', async function (this: JourneyWorld) {
  const registerPage = new RegisterPage(this.page);
  await registerPage.open();
  await registerPage.register(
    generateValue('firstName'),
    generateValue('lastName'),
    this.email!,
    '33',
    'Other',
    this.password!,
    true
  );
});

Then('the "{string}" field should be a password field', async function (this: CustomWorld, label: string) {
  const locator = this.page.getByLabel(label, { exact: true });
  await expect(locator).toHaveAttribute('type', 'password');
});
