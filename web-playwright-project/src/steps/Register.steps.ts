import { Then } from '@cucumber/cucumber';
import { expect } from '@playwright/test';
import { CustomWorld } from '../support/world.js';
import { RegisterPage } from '../pages/RegisterPage.js';

Then('the "{string}" field should be visible', async function (this: CustomWorld, label: string) {
  const registerPage = new RegisterPage(this.page);
  const field = await registerPage.getFieldByLabel(label);
  await expect(field).toBeVisible();
});

Then('the "{string}" field should be a password field', async function (this: CustomWorld, label: string) {
  const registerPage = new RegisterPage(this.page);
  let field;
  if (label === 'Password') {
    field = registerPage.password;
  } else if (label === 'Confirm password') {
    field = registerPage.confirmPassword;
  } else {
    throw new Error(`Label "${label}" is not a known password field.`);
  }
  await expect(field).toHaveAttribute('type', 'password');
});
