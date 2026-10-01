import { type Page } from '@playwright/test';
import { BasePage } from './BasePage.js';

export class LoginPage extends BasePage {

  constructor(page: Page) {
    super(page);
  }

  get email() { return this.page.getByRole('textbox', { name: 'Email', exact: true }); }
  get password() { return this.page.getByRole('textbox', { name: 'Password', exact: true }); }
  get signInButton() { return this.page.getByRole('button', { name: 'Sign in', exact: true }); }
  
}