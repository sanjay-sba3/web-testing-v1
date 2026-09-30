import { expect, Locator } from '@playwright/test';
import { BasePage } from './BasePage.js';

export class RegisterPage extends BasePage {
  get firstName() { return this.page.getByLabel('First Name'); }
  get lastName() { return this.page.getByLabel('Last Name'); }
  get email() { return this.page.getByLabel('Email'); }
  get password() { return this.page.getByLabel('Password'); }
  get confirmPassword() { return this.page.getByLabel('Confirm Password'); }
  get registerButton() { return this.page.getByRole('button', { name: 'Register' }); }
  get loginLink() { return this.page.getByRole('link', { name: 'Login' }); }

  getFieldByName(elementName: string): Locator {
    const name = elementName.toLowerCase();
    if (name === 'first name') return this.firstName;
    if (name === 'last name') return this.lastName;
    if (name === 'email') return this.email;
    if (name === 'password') return this.password;
    if (name === 'confirm password') return this.confirmPassword;
    if (name === 'register') return this.registerButton;
    if (name === 'login') return this.loginLink;
    throw new Error(`Element reference "${elementName}" not found on the Register Page.`);
  }

  async checkValidationError(field: Locator, message: string): Promise<void> {
    // This assumes the error message is a sibling of the input, a common pattern.
    // e.g., <input ... /><div class="error">message</div>
    // A more robust selector would use aria-describedby if available.
    const errorLocator = this.page.getByText(message);
    await expect(errorLocator).toBeVisible();
  }
}
