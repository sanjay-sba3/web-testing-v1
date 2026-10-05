import { When, Then } from '@cucumber/cucumber';
import { CustomWorld } from '../support/world.js';
import { loadTestData } from '../support/testData.js';
import { generateValue } from '../support/testDataGenerator.js';
import { expect } from '@playwright/test';
import { RegistrationPage } from '../pages/RegistrationPage.js';
import { LoginPage } from '../pages/LoginPage.js';

type RegistrationWorld = CustomWorld & { 
  email?: string; 
  password?: string;
  registrationPage?: RegistrationPage;
  loginPage?: LoginPage;
};

When('I register a new user', async function (this: RegistrationWorld) {
  this.registrationPage = new RegistrationPage(this.page);
  this.email = generateValue('email');
  this.password = 'SecurePass123!'; // Fixed literal meeting minlength requirement
  
  await this.registrationPage.fillRegistrationForm({
    firstName: generateValue('firstName'),
    lastName: generateValue('lastName'),
    email: this.email,
    password: this.password,
    confirmPassword: this.password,
    gender: 'Male',
    age: '25',
  });
  
  await this.registrationPage.acceptTerms();
  await this.registrationPage.submitRegistration();
});

When('I sign in as that new user', async function (this: RegistrationWorld) {
  this.loginPage = new LoginPage(this.page);
  await this.loginPage.login(this.email!, this.password!);
});

Then('I am redirected to the dashboard', async function (this: RegistrationWorld) {
  await this.page.waitForURL('**/dashboard');
  expect(this.page.url()).toContain('/dashboard');
});

Then('I should see the {string} link', async function (this: CustomWorld, linkName: string) {
  const link = this.page.getByRole('link', { name: linkName, exact: true });
  await expect(link).toBeVisible();
});
