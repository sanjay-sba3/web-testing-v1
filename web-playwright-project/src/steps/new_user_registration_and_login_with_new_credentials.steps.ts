import { When, Then } from '@cucumber/cucumber';
import { CustomWorld } from '../support/world.js';
import { loadTestData } from '../support/testData.js';
import { generateValue } from '../support/testDataGenerator.js';

// Define types for our world extension
interface RegistrationWorld extends CustomWorld {
  email?: string;
  password?: string;
}

// Load test data
const testData = loadTestData('new_user_registration_and_login_with_new_credentials');

// Custom step definitions
When('I register a new user', async function(this: RegistrationWorld) {
  this.email = generateValue('email');
  this.password = 'Secret123';
  
  await this.page.fill('input[aria-label="First name"]', 'Test');
  await this.page.fill('input[aria-label="Last name"]', 'User');
  await this.page.fill('input[aria-label="Email address"]', this.email);
  await this.page.fill('input[aria-label="Account password"]', this.password);
  await this.page.fill('input[aria-label="Confirm password"]', this.password);
  await this.page.selectOption('select[aria-label="Gender identity"]', 'Male');
  await this.page.fill('input[aria-label="Age (years)"]', '25');
  await this.page.check('input[aria-label="I accept the terms and conditions"]');
  await this.page.click('button:has-text("Create account")');
});

When('I sign in as that new user', async function(this: RegistrationWorld) {
  await this.page.fill('input[aria-label="Email"]', this.email!);
  await this.page.fill('input[aria-label="Password"]', this.password!);
  await this.page.click('button:has-text("Sign in")');
});