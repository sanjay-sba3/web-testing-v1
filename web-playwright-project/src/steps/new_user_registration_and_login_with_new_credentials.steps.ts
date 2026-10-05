import { When, Then } from '@cucumber/cucumber';
import { CustomWorld } from '../support/world.js';
import { loadTestData } from '../support/testData.js';
import { generateValue } from '../support/testDataGenerator.js';
import { expect } from '@playwright/test';
import { RegisterPage } from '../pages/RegisterPage.js';
import { LoginPage } from '../pages/LoginPage.js';

interface RegistrationWorld extends CustomWorld {
  registered_email?: string;
}

When('I register a new user with email {string} and password {string}', async function (this: RegistrationWorld, email: string, password: string) {
  const testData = loadTestData('new_user_registration_and_login_with_new_credentials');
  const registerPage = new RegisterPage(this.page);
  
  this.registered_email = email.replace('{{random.email}}', generateValue('email'));
  
  await registerPage.open('/register');
  await registerPage.fill(registerPage.givenName, 'John');
  await registerPage.fill(registerPage.familyName, 'Doe');
  await registerPage.fill(registerPage.emailAddress, this.registered_email);
  await registerPage.fill(registerPage.mobileNumber, '+1234567890');
  await registerPage.fill(registerPage.age, '25');
  await registerPage.select(registerPage.genderIdentity, 'Male');
  await registerPage.fill(registerPage.accountPassword, password);
  await registerPage.fill(registerPage.confirmPassword, password);
  await registerPage.check(registerPage.acceptTerms);
  await registerPage.click(registerPage.createAccount);
});