import { BasePage } from './BasePage.js';

export class LoginPage extends BasePage {
  get email() {
    return this.page.getByLabel('Email');
  }

  get password() {
    return this.page.getByLabel('Password');
  }

  get signInButton() {
    return this.page.getByRole('button', { name: 'Sign in' });
  }

  async login(email: string, pass: string): Promise<void> {
    await this.fill(this.email, email);
    await this.fill(this.password, pass);
    await this.click(this.signInButton);
  }
}
