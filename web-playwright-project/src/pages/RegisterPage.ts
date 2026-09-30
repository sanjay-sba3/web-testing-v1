import { expect, type Locator, type Page } from '@playwright/test';
import { BasePage } from './BasePage.js';

export class RegisterPage extends BasePage {
  get firstName(): Locator {
    return this.page.getByLabel('First name');
  }

  get lastName(): Locator {
    return this.page.getByLabel('Last name');
  }

  get email(): Locator {
    return this.page.getByLabel('Email');
  }

  get password(): Locator {
    return this.page.getByLabel('Password');
  }

  get confirmPassword(): Locator {
    return this.page.getByLabel('Confirm password');
  }

  get createAccountButton(): Locator {
    return this.page.getByRole('button', { name: 'Create account' });
  }

  get loginLink(): Locator {
    return this.page.getByRole('link', { name: 'Login' });
  }
}