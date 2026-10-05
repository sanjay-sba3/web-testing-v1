import { When, Then } from '@cucumber/cucumber';
import { CustomWorld } from '../support/world.js';
import { generateValue } from '../support/testDataGenerator.js';
import { expect } from '@playwright/test';

type RegistrationWorld = CustomWorld & { 
  email?: string; 
  password?: string;
};

When('I register a new user', async function (this: RegistrationWorld) {
  const firstName = generateValue('firstName');
  const lastName = generateValue('lastName');
  this.email = generateValue('email');
  this.password = 'SecurePass123!';
  
  await this.page.fill('input[aria-label="First name"]', firstName);
  await this.page.fill('input[aria-label="Last name"]', lastName);
  await this.page.fill('input[aria-label="Email address"]', this.email);
  await this.page.fill('input[aria-label="Age (years)"]', '25');
  await this.page.selectOption('select[aria-label="Gender identity"]', 'Male');
  await this.page.fill('input[aria-label="Account password"]', this.password);
  await this.page.fill('input[aria-label="Confirm password"]', this.password);
  await this.page.check('input[aria-label="I accept the terms and conditions"]');
  await this.page.click('button:has-text("Create account")');
});

When('I sign in as that new user', async function (this: RegistrationWorld) {
  await this.page.fill('input[aria-label="Email"]', this.email!);
  await this.page.fill('input[aria-label="Password"]', this.password!);
  await this.page.click('button:has-text("Sign in")');
});

Then('the {string} button should be focused', async function (this: CustomWorld, buttonName: string) {
  const button = this.page.getByRole('button', { name: buttonName, exact: true });
  await expect(button).toBeFocused();
});

Then('I should see the {string} link', async function (this: CustomWorld, linkName: string) {
  const link = this.page.getByRole('link', { name: linkName, exact: true });
  await expect(link).toBeVisible();
});