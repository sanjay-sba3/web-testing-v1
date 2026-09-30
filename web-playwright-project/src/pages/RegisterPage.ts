import { Locator } from '@playwright/test';
import { BasePage } from './BasePage.js';

export class RegisterPage extends BasePage {
  get firstName() { return this.page.getByLabel('First name'); }
  get lastName() { return this.page.getByLabel('Last name'); }
  get email() { return this.page.getByLabel('Email'); }
  get phone() { return this.page.getByLabel('Phone'); }
  get age() { return this.page.getByLabel('Age'); }
  get gender() { return this.page.getByLabel('Gender'); }
  get password() { return this.page.getByLabel('Password'); }
  get confirmPassword() { return this.page.getByLabel('Confirm password'); }
  get acceptTerms() { return this.page.getByLabel('I accept the terms'); }
  get createAccountButton() { return this.page.getByRole('button', { name: 'Create account' }); }
  get loginLink() { return this.page.getByRole('link', { name: 'Login' }); }

  getFieldByLabel(label: string): Locator {
    return this.page.getByLabel(label);
  }
}
