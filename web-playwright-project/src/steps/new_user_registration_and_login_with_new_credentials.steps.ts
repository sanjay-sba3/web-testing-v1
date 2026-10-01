import { Before, When, Then } from '@cucumber/cucumber';
import { expect } from '@playwright/test';
import { CustomWorld } from '../support/world.js';
import { generateValue } from '../support/testDataGenerator.js';
import { RegisterPage } from '../pages/RegisterPage.js';

type JourneyWorld = CustomWorld & { dialogMessage?: string | null };

Before({ tags: '@checks-for-dialog' }, async function (this: JourneyWorld) {
  this.dialogMessage = null;
  this.page.on('dialog', dialog => {
    this.dialogMessage = dialog.message();
    dialog.dismiss().catch(() => {}); // Suppress errors if page closes before dismiss completes
  });
});

When('I register a new user with valid details', async function (this: CustomWorld) {
  const registerPage = new RegisterPage(this.page);
  await registerPage.fill(registerPage.givenName, generateValue('firstName', 'random'));
  await registerPage.fill(registerPage.familyName, generateValue('lastName', 'random'));
  await registerPage.fill(registerPage.emailAddress, generateValue('email', 'random'));
  await registerPage.fill(registerPage.mobileNumber, '+1 555 555 1234');
  await registerPage.fill(registerPage.age, '30');
  await registerPage.genderIdentity.selectOption('Male');
  const password = 'ValidPassword123!';
  await registerPage.fill(registerPage.accountPassword, password);
  await registerPage.fill(registerPage.confirmPassword, password);
  await registerPage.check(registerPage.termsCheckbox);
  await registerPage.click(registerPage.createAccountButton);
});

Then('I should see the {string} {word}', async function (this: CustomWorld, name: string, role: string) {
  const locator = this.page.getByRole(role as any, { name, exact: true });
  await expect(locator).toBeVisible();
});

Then('the {string} field should be masked', async function (this: CustomWorld, label: string) {
  const field = this.page.getByRole('textbox', { name: label, exact: true });
  await expect(field).toHaveAttribute('type', 'password');
});

Then('no alert dialog should appear', async function (this: JourneyWorld) {
  expect(this.dialogMessage).toBeNull();
});
