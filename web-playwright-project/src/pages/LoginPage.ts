import { BasePage } from './BasePage.js';

export class LoginPage extends BasePage {
  get emailInput() {
    return this.page.getByLabel('Email');
  }

  get passwordInput() {
    return this.page.getByLabel('Password');
  }

  get signInButton() {
    return this.page.getByRole('button', { name: 'Sign in' });
  }

  async login(email: string, pass: string): Promise<void> {
    await this.fill(this.emailInput, email);
    await this.fill(this.passwordInput, pass);
    await this.click(this.signInButton);
  }
}
