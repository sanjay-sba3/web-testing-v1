import { When, Then } from '@cucumber/cucumber';
import { CustomWorld } from '../support/world.js';
import { loadTestData } from '../support/testData.js';
import { generateValue } from '../support/testDataGenerator.js';
import { expect } from '@playwright/test';

// Define types for our custom world extension
type RegistrationWorld = CustomWorld & { 
  registeredEmail?: string;
  registeredPassword?: string;
};

// Load test data
const testData = loadTestData('new_user_registration_and_login_with_new_credentials');

// Step for registering a new user
When('I register a new user with valid data', async function (this: RegistrationWorld) {
  const page = this.page;
  
  // Generate unique data for registration
  this.registeredEmail = generateValue('email');
  this.registeredPassword = 'SecurePass123!'; // Using fixed password that meets requirements
  
  // Fill all required fields
  await page.getByRole('textbox', { name: 'First name', exact: true }).fill('John');
  await page.getByRole('textbox', { name: 'Last name', exact: true }).fill('Doe');
  await page.getByRole('textbox', { name: 'Email address', exact: true }).fill(this.registeredEmail);
  await page.getByRole('textbox', { name: 'Account password', exact: true }).fill(this.registeredPassword);
  await page.getByRole('textbox', { name: 'Confirm password', exact: true }).fill(this.registeredPassword);
  await page.getByRole('combobox', { name: 'Gender identity', exact: true }).selectOption('Male');
  await page.getByRole('checkbox', { name: 'I accept the terms and conditions', exact: true }).check();
  await page.getByRole('spinbutton', { name: 'Age (years)', exact: true }).fill('25');
  
  // Submit the form
  await page.getByRole('button', { name: 'Create account', exact: true }).click();
});

// Step for logging in as the newly registered user
When('I log in with the new credentials', async function (this: RegistrationWorld) {
  const page = this.page;
  
  // Click the sign in link after registration
  await page.getByRole('link', { name: 'Sign in', exact: true }).click();
  
  // Fill login form with registered credentials
  await page.getByRole('textbox', { name: 'Email', exact: true }).fill(this.registeredEmail!);
  await page.getByRole('textbox', { name: 'Password', exact: true }).fill(this.registeredPassword!);
  
  // Submit login form
  await page.getByRole('button', { name: 'Sign in', exact: true }).click();
});

// Assertion step for checking password field type
Then('the {string} field should have type {string}', async function (this: CustomWorld, fieldName: string, fieldType: string) {
  const page = this.page;
  const field = page.getByRole('textbox', { name: fieldName, exact: true });
  await expect(field).toHaveAttribute('type', fieldType);
});

// Assertion step for checking if a link is visible
Then('I should see the {string} link', async function (this: CustomWorld, linkName: string) {
  const page = this.page;
  const link = page.getByRole('link', { name: linkName, exact: true });
  await expect(link).toBeVisible();
});