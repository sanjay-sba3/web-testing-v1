import { BasePage } from './BasePage.js';
import { expect } from '@playwright/test';

export class LoginPage extends BasePage {
  get email() { return this.page.getByRole('textbox', { name: 'Email', exact: true }); }
  get password() { return this.page.getByRole('textbox', { name: 'Password', exact: true }); }
  get signInButton() { return this.page.getByRole('button', { name: 'Sign in', exact: true }); }

  async open() {
    await super.open('http://localhost:3000/login');
    await expect(this.signInButton).toBeVisible();
  }

  async login(email: string, password: string): Promise<void> {
    await this.fill(this.email, email);
    await this.fill(this.password, password);
    await this.click(this.signInButton);
  }
}