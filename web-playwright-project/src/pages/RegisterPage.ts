import { Locator } from '@playwright/test';
import { BasePage } from './BasePage.js';

export class RegisterPage extends BasePage {
  // Locators are based on test case names, as no snapshot was provided for register.html
  get firstName() { return this.page.getByRole('textbox', { name: 'First Name', exact: true }); }
  get lastName() { return this.page.getByRole('textbox', { name: 'Last Name', exact: true }); }
  get email() { return this.page.getByRole('textbox', { name: 'Email', exact: true }); }
  get password() { return this.page.getByRole('textbox', { name: 'Password', exact: true }); }
  get confirmPassword() { return this.page.getByRole('textbox', { name: 'Confirm Password', exact: true }); }
  get registerButton() { return this.page.getByRole('button', { name: 'Register', exact: true }); }
  get loginLink() { return this.page.getByRole('link', { name: 'Have an account?', exact: true }); }

  /**
   * Returns a locator for a form field by its accessible name (label).
   * @param label The accessible name of the field.
   */
  getFieldByLabel(label: string): Locator {
    return this.page.getByRole('textbox', { name: label, exact: true });
  }

  /**
   * Returns a locator for an element by its accessible name and type.
   * @param name The accessible name of the element.
   * @param type The type of element ('field', 'button', 'link').
   */
  getElement(name: string, type: 'field' | 'button' | 'link' | string): Locator {
    switch (type) {
      case 'field':
        return this.getFieldByLabel(name);
      case 'button':
        return this.page.getByRole('button', { name, exact: true });
      case 'link':
        return this.page.getByRole('link', { name, exact: true });
      default:
        throw new Error(`Unsupported element type: '${type}' for element '${name}'`);
    }
  }
}
