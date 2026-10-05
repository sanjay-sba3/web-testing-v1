import { BasePage } from './BasePage.js';

export class LoginPage extends BasePage {
  get emailAddress() { return this.page.getByRole('textbox', { name: 'Email address', exact: true }); }
  get password() { return this.page.getByRole('textbox', { name: 'Password', exact: true }); }
  get signIn() { return this.page.getByRole('button', { name: 'Sign in', exact: true }); }
}