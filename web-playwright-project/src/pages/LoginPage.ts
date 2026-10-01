import { Locator, Page } from '@playwright/test';
import { BasePage } from './BasePage.js';

export class LoginPage extends BasePage {
  get email(): Locator {
    return this.page.getByRole('textbox', { name: 'Email', exact: true });
  }

  get password(): Locator {
    return this.page.getByRole('textbox', { name: 'Password', exact: true });
  }

  get signInButton(): Locator {
    return this.page.getByRole('button', { name: 'Sign in', exact: true });
  }

  async login(email: string, password: string): Promise<void> {
    await this.fill(this.email, email);
    await this.fill(this.password, password);
    await this.click(this.signInButton);
  }
}
