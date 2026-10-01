import { Locator } from '@playwright/test';
import { BasePage } from './BasePage.js';

export class LoginPage extends BasePage {
  get email(): Locator {
    return this.page.getByRole('textbox', { name: 'Email', exact: true });
  }

  get password(): Locator {
    return this.page.getByRole('textbox', { name: 'Password', exact: true });
  }

  get signIn(): Locator {
    return this.page.getByRole('button', { name: 'Sign in', exact: true });
  }

  get createAccountLink(): Locator {
    return this.page.getByRole('link', { name: 'Create account', exact: true });
  }

  get rememberMyEmail(): Locator {
    return this.page.getByRole('checkbox', { name: 'Remember my email', exact: true });
  }

  get showPasswordButton(): Locator {
    return this.page.getByRole('button', { name: 'Show', exact: true });
  }
}