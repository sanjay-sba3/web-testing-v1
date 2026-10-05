import { When, Then } from '@cucumber/cucumber';
import { expect } from '@playwright/test';
import { CustomWorld } from '../support/world.js';
import { loadTestData } from '../support/testData.js';
import { generateValue } from '../support/testDataGenerator.js';
import { RegisterPage } from '../pages/RegisterPage.js';
import { LoginPage } from '../pages/LoginPage.js';

const DATA_FILE = 'new_user_registration_and_login_with_new_credentials';

interface RegistrationTestData {
  password: string;
  existingEmail: string;
  mobileNumber: string;
  age: string;
  gender: string;
}

type JourneyWorld = CustomWorld & { email?: string; password?: string; dialogs?: string[] };

function testData(): RegistrationTestData {
  return loadTestData<RegistrationTestData>(DATA_FILE);
}

When('I register a new user', async function (this: JourneyWorld) {
  const data = testData();
  this.email = generateValue('email');
  this.password = data.password;
  await new RegisterPage(this.page).register({
    givenName: generateValue('firstName'),
    familyName: generateValue('lastName'),
    email: this.email,
    mobile: data.mobileNumber,
    age: data.age,
    gender: data.gender,
    password: this.password,
  });
});

When('I register a user with the same email again', async function (this: JourneyWorld) {
  const data = testData();
  await new RegisterPage(this.page).register({
    givenName: generateValue('firstName'),
    familyName: generateValue('lastName'),
    email: this.email!,
    mobile: data.mobileNumber,
    age: data.age,
    gender: data.gender,
    password: this.password!,
  });
});

When('I sign in as that new user', async function (this: JourneyWorld) {
  await new LoginPage(this.page).login(this.email!, this.password!);
});

When('I complete the registration form using only the keyboard', async function (this: JourneyWorld) {
  const data = testData();
  const register = new RegisterPage(this.page);
  const keyboard = this.page.keyboard;

  this.email = generateValue('email');
  this.password = data.password;

  await register.givenName.focus();
  await keyboard.type(generateValue('firstName'));
  await keyboard.press('Tab');
  await keyboard.type(generateValue('lastName'));
  await keyboard.press('Tab');
  await keyboard.type(this.email);
  await keyboard.press('Tab');
  await keyboard.type(data.mobileNumber);
  await keyboard.press('Tab');
  await keyboard.type(data.age);
  await keyboard.press('Tab');
  // select type-ahead: the first letter picks the option ("F" -> "Female")
  await keyboard.press(data.gender.charAt(0));
  await keyboard.press('Tab');
  await keyboard.type(this.password);
  await keyboard.press('Tab');
  await keyboard.type(this.password);
  await keyboard.press('Tab');
  await keyboard.press('Space');
  await keyboard.press('Tab');
  await keyboard.press('Enter');
});

When('I sign in using only the keyboard', async function (this: CustomWorld) {
  const data = testData();
  const login = new LoginPage(this.page);
  await login.email.focus();
  await this.page.keyboard.type(data.existingEmail);
  await this.page.keyboard.press('Tab');
  await this.page.keyboard.type(data.password);
  await this.page.keyboard.press('Enter');
});

When('I reload the page', async function (this: CustomWorld) {
  await this.page.reload();
});

When('I start watching for browser dialogs', function (this: JourneyWorld) {
  const opened: string[] = [];
  this.dialogs = opened;
  this.page.on('dialog', async (dialog) => {
    opened.push(dialog.message());
    await dialog.dismiss();
  });
});

Then('no browser dialog should have opened', function (this: JourneyWorld) {
  expect(this.dialogs ?? []).toEqual([]);
});

Then('the {string} password field should be masked', async function (this: CustomWorld, label: string) {
  await expect(this.page.getByRole('textbox', { name: label, exact: true })).toHaveAttribute('type', 'password');
});

Then('the URL should not contain the value of env {string}', function (this: CustomWorld, name: string) {
  const value = process.env[name];
  expect(value, `Environment variable ${name} is not set`).toBeTruthy();
  expect(this.page.url()).not.toContain(value!);
});
