import { BasePage } from './BasePage.js';

export class LoginPage extends BasePage {
  get successMessage() { return this.page.getByText('Registration successful. Please login.'); }
  get pageHeader() { return this.page.getByText('Login to your account'); }
}
