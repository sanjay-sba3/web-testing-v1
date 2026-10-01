import { When, Then } from '@cucumber/cucumber';
import { expect } from '@playwright/test';
import { CustomWorld } from '../support/world.js';
import { generateValue } from '../support/testDataGenerator.js';
import { loadTestData } from '../support/testData.js';
import { RegistrationPage } from '../pages/RegistrationPage.js';
import { LoginPage } from '../pages/LoginPage.js';

type JourneyWorld = CustomWorld & { email?: string; password?: string };
const testData = loadTestData('new_user_registration_and_login_with_new_credentials');

When('I register a new user', async function (this: JourneyWorld) {
  const registrationPage = new RegistrationPage(this.page);
  this.email = generateValue('email');
  this.password = testData.password;

  await registrationPage.fill(registrationPage.givenName, generateValue('givenName'));
  await registrationPage.fill(registrationPage.familyName, generateValue('familyName'));
  await registrationPage.fill(registrationPage.emailAddress, this.email);
  await registrationPage.fill(registrationPage.age, '25');
  await registrationPage.select(registrationPage.genderIdentity, 'Male');
  await registrationPage.fill(registrationPage.accountPassword, this.password);
  await registrationPage.fill(registrationPage.confirmPassword, this.password);
  await registrationPage.check(registrationPage.termsAndConditions);
  await registrationPage.click(registrationPage.createAccountButton);
});

When('I sign in as that new user', async function (this: JourneyWorld) {
  if (!this.email || !this.password) {
    throw new Error('User credentials were not generated in a previous step.');
  }
  const loginPage = new LoginPage(this.page);
  await loginPage.fill(loginPage.email, this.email);
  await loginPage.fill(loginPage.password, this.password);
  await loginPage.click(loginPage.signInButton);
});

When('I fill all required registration fields', async function (this: CustomWorld) {
  const registrationPage = new RegistrationPage(this.page);
  await registrationPage.fill(registrationPage.givenName, generateValue('givenName'));
  await registrationPage.fill(registrationPage.familyName, generateValue('familyName'));
  // Email, passwords, etc., will be filled by subsequent steps for the specific test case
  await registrationPage.fill(registrationPage.age, '30');
  await registrationPage.select(registrationPage.genderIdentity, 'Female');
  await registrationPage.check(registrationPage.termsAndConditions);
});

Then('the registration form is displayed correctly', async function (this: CustomWorld) {
  const registrationPage = new RegistrationPage(this.page);
  await registrationPage.expectVisible(registrationPage.emailAddress);
  await registrationPage.expectVisible(registrationPage.accountPassword);
  await registrationPage.expectVisible(registrationPage.confirmPassword);
  await registrationPage.expectVisible(registrationPage.createAccountButton);
});

Then('the login form is displayed correctly', async function (this: CustomWorld) {
  const loginPage = new LoginPage(this.page);
  await loginPage.expectVisible(loginPage.email);
  await loginPage.expectVisible(loginPage.password);
  await loginPage.expectVisible(loginPage.signInButton);
});

Then('the text in the {string} field is masked', async function (this: CustomWorld, label: string) {
  const locator = this.page.getByRole('textbox', { name: label, exact: true });
  await expect(locator).toHaveAttribute('type', 'password');
});

Then('the URL should be {string}', async function (this: CustomWorld, url: string) {
  await expect(this.page).toHaveURL(url);
});
