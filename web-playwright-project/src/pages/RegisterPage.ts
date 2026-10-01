import { Locator } from '@playwright/test';
import { BasePage } from './BasePage.js';

export class RegisterPage extends BasePage {
  get firstName() { return this.page.getByRole('textbox', { name: 'First name', exact: true }); }
  get lastName() { return this.page.getByRole('textbox', { name: 'Last name', exact: true }); }
  get email() { return this.page.getByRole('textbox', { name: 'Email', exact: true }); }
  get phone() { return this.page.getByRole('textbox', { name: 'Phone', exact: true }); }
  get age() { return this.page.getByRole('spinbutton', { name: 'Age', exact: true }); }
  get gender() { return this.page.getByRole('combobox', { name: 'Gender', exact: true }); }
  get password() { return this.page.getByRole('textbox', { name: 'Password', exact: true }); }
  get confirmPassword() { return this.page.getByRole('textbox', { name: 'Confirm password', exact: true }); }
  get acceptTerms() { return this.page.getByRole('checkbox', { name: 'I accept the terms', exact: true }); }
  get createAccount() { return this.page.getByRole('button', { name: 'Create account', exact: true }); }
  get loginLink() { return this.page.getByRole('link', { name: 'Login', exact: true }); }

  /**
   * Returns a locator for a given form field label.
   * This is useful for creating generic steps that can refer to fields by their label text.
   * @param label The accessible name of the form field.
   * @returns The corresponding Playwright Locator.
   */
  getLocatorByLabel(label: string): Locator {
    switch (label) {
      case 'First name': return this.firstName;
      case 'Last name': return this.lastName;
      case 'Email': return this.email;
      case 'Phone': return this.phone;
      case 'Age': return this.age;
      case 'Gender': return this.gender;
      case 'Password': return this.password;
      case 'Confirm password': return this.confirmPassword;
      case 'I accept the terms': return this.acceptTerms;
      default:
        throw new Error(`Locator for label "${label}" not found in RegisterPage.`);
    }
  }
}
