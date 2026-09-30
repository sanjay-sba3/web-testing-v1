import { BasePage } from './BasePage.js';

export class RegisterPage extends BasePage {
  // TODO: Locators inferred, not from a captured DOM snapshot for the register page.

  get usernameInput() { return this.page.getByLabel('Username'); }
  get emailInput() { return this.page.getByLabel('Email'); }
  get passwordInput() { return this.page.getByLabel('Password'); }
  get confirmPasswordInput() { return this.page.getByLabel('Confirm Password'); }
  get registerButton() { return this.page.getByRole('button', { name: 'Register' }); }
  get loginLink() { return this.page.getByRole('link', { name: 'Login' }); }
}
