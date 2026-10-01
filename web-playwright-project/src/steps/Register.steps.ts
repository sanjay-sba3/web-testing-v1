import { Then } from '@cucumber/cucumber';
import { expect } from '@playwright/test';
import { CustomWorld } from '../support/world.js';
import { RegisterPage } from '../pages/RegisterPage.js';

Then('I should see the main registration form elements', async function (this: CustomWorld) {
  const registerPage = new RegisterPage(this.page);
  await expect(registerPage.firstName).toBeVisible();
  await expect(registerPage.lastName).toBeVisible();
  await expect(registerPage.email).toBeVisible();
  await expect(registerPage.password).toBeVisible();
  await expect(registerPage.confirmPassword).toBeVisible();
  await expect(registerPage.createAccount).toBeVisible();
});

Then('the "Password" and "Confirm password" fields should be masked', async function (this: CustomWorld) {
  const registerPage = new RegisterPage(this.page);
  await expect(registerPage.password).toHaveAttribute('type', 'password');
  await expect(registerPage.confirmPassword).toHaveAttribute('type', 'password');
});

Then('I can tab through the form fields in order', async function (this: CustomWorld) {
  const registerPage = new RegisterPage(this.page);
  await this.page.keyboard.press('Tab');
  await expect(registerPage.firstName).toBeFocused();
  await this.page.keyboard.press('Tab');
  await expect(registerPage.lastName).toBeFocused();
  await this.page.keyboard.press('Tab');
  await expect(registerPage.email).toBeFocused();
  await this.page.keyboard.press('Tab');
  await expect(registerPage.phone).toBeFocused();
  await this.page.keyboard.press('Tab');
  await expect(registerPage.age).toBeFocused();
  await this.page.keyboard.press('Tab');
  await expect(registerPage.gender).toBeFocused();
  await this.page.keyboard.press('Tab');
  await expect(registerPage.password).toBeFocused();
  await this.page.keyboard.press('Tab');
  await expect(registerPage.confirmPassword).toBeFocused();
  await this.page.keyboard.press('Tab');
  await expect(registerPage.acceptTerms).toBeFocused();
  await this.page.keyboard.press('Tab');
  await expect(registerPage.createAccount).toBeFocused();
});
