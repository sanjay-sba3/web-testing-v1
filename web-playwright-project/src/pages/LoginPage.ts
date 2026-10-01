import { BasePage } from './BasePage.js';

export class LoginPage extends BasePage {
  get email() { return this.page.getByRole('textbox', { name: 'Email', exact: true }); }
  get password() { return this.page.getByRole('textbox', { name: 'Password', exact: true }); }
  get signInButton() { return this.page.getByRole('button', { name: 'Sign in', exact: true }); }
}