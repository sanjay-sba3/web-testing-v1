import { When, Then } from '@cucumber/cucumber';
import { expect } from '@playwright/test';
import { CustomWorld } from '../support/world.js';
import { generateValue } from '../support/testDataGenerator.js';
import { RegisterPage } from '../pages/RegisterPage.js';
import { LoginPage } from '../pages/LoginPage.js';

type JourneyWorld = CustomWorld & { email?: string; password?: string };

When('I register a new user with valid details', async function (this: JourneyWorld) {
  const registerPage = new RegisterPage(this.page);

  this.email = generateValue('email');
  this.password = 'ValidPassword123!';

  await registerPage.fill(registerPage.givenName, generateValue('firstName'));
  await registerPage.fill(registerPage.familyName, generateValue('lastName'));
  await registerPage.fill(registerPage.emailAddress, this.email);
  await registerPage.fill(registerPage.age, '25');
  await registerPage.select(registerPage.gender, { label: 'Male' });
  await registerPage.fill(registerPage.accountPassword, this.password);
  await registerPage.fill(registerPage.confirmPassword, this.password);
  await registerPage.check(registerPage.termsAndConditions);
  await registerPage.click(registerPage.createAccountButton);
});

When('I log in with the new user credentials', async function (this: JourneyWorld) {
  if (!this.email || !this.password) {
    throw new Error('User credentials not found. Did you register first?');
  }
  const loginPage = new LoginPage(this.page);
  await loginPage.fill(loginPage.email, this.email);
  await loginPage.fill(loginPage.password, this.password);
  await loginPage.click(loginPage.signInButton);
});

Then('the {string} textbox should be masked', async function (this: CustomWorld, label: string) {
  const field = this.page.getByRole('textbox', { name: label, exact: true });
  await expect(field).toHaveAttribute('type', 'password');
});
