import { type Locator } from '@playwright/test';
import { BasePage } from './BasePage.js';

export class LoginPage extends BasePage {
  // Locators are based on assumptions from test case TC11 as no snapshot was provided.
  get email(): Locator {
    return this.page.getByLabel('Email'); // Assumed label
  }

  get password(): Locator {
    return this.page.getByLabel('Password'); // Assumed label
  }

  get loginButton(): Locator {
    return this.page.getByRole('button', { name: 'Log in' }); // Assumed accessible name
  }
}