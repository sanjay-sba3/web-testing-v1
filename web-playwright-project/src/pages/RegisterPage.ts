import { BasePage } from './BasePage.js';

export class RegisterPage extends BasePage {
  get firstName() { return this.page.getByLabel('First name'); }
  get lastName() { return this.page.getByLabel('Last name'); }
  get email() { return this.page.getByLabel('Email'); }
  get password() { return this.page.getByLabel('Password'); }
  get confirmPassword() { return this.page.getByLabel('Confirm password'); }
  get termsCheckbox() { return this.page.getByLabel('I accept the terms'); }
  get createAccountButton() { return this.page.getByRole('button', { name: 'Create account' }); }
  get loginLink() { return this.page.getByRole('link', { name: 'Login' }); }
}
