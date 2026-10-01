import { When, Then, Given, DataTable } from '@cucumber/cucumber';
import { expect } from '@playwright/test';
import { CustomWorld } from '../support/world.js';
import { RegistrationPage } from '../pages/RegistrationPage.js';
import { LoginPage } from '../pages/LoginPage.js';
import { generateValue } from '../support/testDataGenerator.js';
import { loadTestData } from '../support/testData.js';
import { Locator } from 'playwright';

const testData = loadTestData('new_user_registration');

function ensurePageObjects(world: CustomWorld) {
  if (!(world as any).registrationPage) {
    (world as any).registrationPage = new RegistrationPage(world.page);
  }
  if (!(world as any).loginPage) {
    (world as any).loginPage = new LoginPage(world.page);
  }
}

async function fillRegistrationForm(world: CustomWorld, overrides: { [key: string]: string | null } = {}) {
  ensurePageObjects(world);
  const page = (world as any).registrationPage as RegistrationPage;
  const email = overrides.email === undefined ? generateValue('email') : overrides.email;
  if (email) await (world as any).fill(page.emailAddress, email);
  (world as any).sharedData.email = email;
  
  const password = overrides.password === undefined ? 'TestPass123!' : overrides.password;
  if (password) await (world as any).fill(page.accountPassword, password);
  (world as any).sharedData.password = password;

  const confirmPassword = overrides.confirmPassword === undefined ? password : overrides.confirmPassword;
  if (confirmPassword) await (world as any).fill(page.confirmPassword, confirmPassword);

  if (overrides.givenName !== null) await (world as any).fill(page.givenName, overrides.givenName || generateValue('firstName'));
  if (overrides.familyName !== null) await (world as any).fill(page.familyName, overrides.familyName || generateValue('lastName'));
  if (overrides.age !== null) await (world as any).fill(page.age, overrides.age || '30');
  if (overrides.gender !== null) await (world as any).select('Male', 'Gender identity');
  if (overrides.terms !== null) await (world as any).check('I accept the terms and conditions');
}

When('I register a new user with a random email and password {string}', async function (this: CustomWorld, password: string) {
  await fillRegistrationForm(this, { password, confirmPassword: password });
  await this.click(((this as any).registrationPage as RegistrationPage).createAccount);
});

When('I log in with the new user\'s credentials', async function (this: CustomWorld) {
  ensurePageObjects(this);
  await this.fill(((this as any).loginPage as LoginPage).email, this.sharedData.email);
  await this.fill(((this as any).loginPage as LoginPage).password, this.sharedData.password);
});

When('I fill the registration form with valid data but with non-matching passwords', async function (this: CustomWorld) {
  await fillRegistrationForm(this, { confirmPassword: testData.mismatchedPassword });
});

When('I fill the registration form with the existing email {string}', async function (this: CustomWorld, email: string) {
  await fillRegistrationForm(this, { email });
});

Then('the {string} textbox is visible', async function (this: CustomWorld, label: string) {
  await expect(this.page.getByRole('textbox', { name: label, exact: true })).toBeVisible();
});

Then('the {string} field should be a password field', async function (this: CustomWorld, label: string) {
  await expect(this.page.getByRole('textbox', { name: label, exact: true })).toHaveAttribute('type', 'password');
});

async function getLocatorByLabel(world: CustomWorld, label: string): Promise<Locator> {
    ensurePageObjects(world);
    const regPage = (world as any).registrationPage as RegistrationPage;
    const loginPage = (world as any).loginPage as LoginPage;
    const locators: Record<string, Locator> = {
      'Given name': regPage.givenName,
      'Family name': regPage.familyName,
      'Email address': regPage.emailAddress,
      'Mobile number': regPage.mobileNumber,
      'Age (years)': regPage.age,
      'Gender identity': regPage.genderIdentity,
      'Account password': regPage.accountPassword,
      'Confirm password': regPage.confirmPassword,
      'I accept the terms and conditions': regPage.termsAndConditions,
      'Create account': regPage.createAccount,
      'Email': loginPage.email,
      'Password': loginPage.password,
      'Show': loginPage.showPassword,
      'Remember my email': loginPage.rememberMyEmail,
      'Sign in': loginPage.signIn
    };
    const locator = locators[label] || world.page.getByRole('link', { name: label, exact: true });
    if (!locator) throw new Error(`Locator for label "${label}" not found.`);
    return locator;
}

Then('I can tab through the {word} form fields in order:', async function (this: CustomWorld, form: string, dataTable: DataTable) {
  const fieldLabels = dataTable.raw().slice(1).map(row => row[0]);
  await this.page.locator('body').focus(); 

  for (const label of fieldLabels) {
    await this.page.keyboard.press('Tab');
    const locator = await getLocatorByLabel(this, label);
    await expect(locator).toBeFocused({ timeout: 2000 });
  }
});
