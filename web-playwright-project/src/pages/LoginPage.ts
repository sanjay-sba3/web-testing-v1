import { BasePage } from './BasePage.js';

export class LoginPage extends BasePage {
  get email() { return this.page.getByLabel('Email'); }
  get password() { return this.page.getByLabel('Password'); }
  get signIn() { return this.page.getByRole('button', { name: 'Sign in' }); }
}
