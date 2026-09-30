import { Then } from '@cucumber/cucumber';
import { expect } from '@playwright/test';
import { CustomWorld } from '../support/world.js';
import { loadTestData } from '../support/testData.js';
import { LoginPage } from '../pages/LoginPage.js';

interface LoginData {
  username: string;
}

const data = await loadTestData<LoginData>('Login');

Then('I should not see a welcome message for the user', async function (this: CustomWorld) {
  const welcomeText = `Hi ${data.username}`;
  await expect(this.page.getByText(welcomeText)).not.toBeVisible();
});

Then('I should see the "{string}" field', async function (this: CustomWorld, fieldLabel: string) {
  const { loginPage } = this.po;
  switch (fieldLabel) {
    case 'Email':
      await expect(loginPage.emailInput).toBeVisible();
      break;
    case 'Password':
      await expect(loginPage.passwordInput).toBeVisible();
      break;
    default:
      throw new Error(`Field with label "${fieldLabel}" is not defined on the Login Page.`);
  }
});

Then('the "{string}" field should be masked', async function (this: CustomWorld, fieldLabel: string) {
  const { loginPage } = this.po;
  if (fieldLabel === 'Password') {
    await expect(loginPage.passwordInput).toHaveAttribute('type', 'password');
  } else {
    throw new Error(`Field with label "${fieldLabel}" is not defined as a masked field.`);
  }
});
