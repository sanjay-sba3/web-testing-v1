import { When, Then } from '@cucumber/cucumber';
import { CustomWorld } from '../support/world.js';
import { generateValue } from '../support/testDataGenerator.js';
import { expect } from '@playwright/test';
import { RegisterPage } from '../pages/RegisterPage.js';
import { LoginPage } from '../pages/LoginPage.js';

type JourneyWorld = CustomWorld & { registeredEmail?: string; registeredPassword?: string };

When('I register a new user', async function (this: JourneyWorld) {
  const registerPage = new RegisterPage(this.page);
  this.registeredEmail = generateValue('email');
  this.registeredPassword = 'ValidPass123!';
  
  await registerPage.fill(registerPage.givenName, generateValue('firstName'));
  await registerPage.fill(registerPage.familyName, generateValue('lastName'));
  await registerPage.fill(registerPage.emailAddress, this.registeredEmail);
  await registerPage.fill(registerPage.age, '25');
  await registerPage.select(registerPage.genderIdentity, 'Male');
  await registerPage.fill(registerPage.accountPassword, this.registeredPassword);
  await registerPage.fill(registerPage.confirmPassword, this.registeredPassword);
  await registerPage.check(registerPage.acceptTerms);
  await registerPage.click(registerPage.createAccount);
});

When('I fill "Email address" with the registered email', async function (this: JourneyWorld) {
  const loginPage = new LoginPage(this.page);
  await loginPage.fill(loginPage.emailAddress, this.registeredEmail || '');
});

When('I fill "Password" with the registered password', async function (this: JourneyWorld) {
  const loginPage = new LoginPage(this.page);
  await loginPage.fill(loginPage.password, this.registeredPassword || '');
});

Then('the registered email should be {string}', async function (this: JourneyWorld, email: string) {
  expect(this.registeredEmail).toEqual(email);
});

Then('the registered password should be {string}', async function (this: JourneyWorld, password: string) {
  expect(this.registeredPassword).toEqual(password);
});