import { When, Then, Given } from '@cucumber/cucumber';
import { expect } from '@playwright/test';
import { CustomWorld } from '../support/world.js';
import { generateValue } from '../support/testDataGenerator.js';
import { RegisterPage } from '../pages/RegisterPage.js';
import { LoginPage } from '../pages/LoginPage.js';

type WorldWithEmail = CustomWorld & { newEmail?: string };

Then('I should see the {string} field', async function (this: CustomWorld, label: string) {
  await expect(this.page.getByRole('textbox', { name: label, exact: true })).toBeVisible();
});

When('I fill the registration form and remember the email', async function (this: WorldWithEmail) {
  const registerPage = new RegisterPage(this.page);
  const password = process.env.APP_PASSWORD || 'defaultSecurePassword123!';
  this.newEmail = generateValue('email', 'random');

  await registerPage.givenName.fill(generateValue('firstName', 'random'));
  await registerPage.familyName.fill(generateValue('firstName', 'random'));
  await registerPage.emailAddress.fill(this.newEmail);
  await registerPage.age.fill('28');
  await registerPage.genderIdentity.selectOption('Female');
  await registerPage.accountPassword.fill(password);
  await registerPage.confirmPassword.fill(password);
  await registerPage.termsCheckbox.check();
  await registerPage.createAccountButton.click();
});

When('I log in with the remembered credentials', async function (this: WorldWithEmail) {
  const loginPage = new LoginPage(this.page);
  const password = process.env.APP_PASSWORD || 'defaultSecurePassword123!';
  if (!this.newEmail) {
    throw new Error('No email was remembered from the registration step.');
  }
  await loginPage.email.fill(this.newEmail);
  await loginPage.password.fill(password);
  await loginPage.signInButton.click();
});

Then('the {string} field should be a password field', async function (this: CustomWorld, label: string) {
  await expect(this.page.getByRole('textbox', { name: label, exact: true })).toHaveAttribute('type', 'password');
});

Then('the {string} field should be focused', async function (this: CustomWorld, label: string) {
    await expect(this.page.getByRole('textbox', { name: label, exact: true })).toBeFocused();
});

Then('the {string} button should be focused', async function (this: CustomWorld, name: string) {
    await expect(this.page.getByRole('button', { name, exact: true })).toBeFocused();
});
