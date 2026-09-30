import { BasePage } from './BasePage.js';
import { Locator, Page } from '@playwright/test';

export class RegisterPage extends BasePage {
  constructor(page: Page) {
    super(page);
  }

  get firstName() { return this.page.getByRole('textbox', { name: 'First name', exact: true }); }
  get lastName() { return this.page.getByRole('textbox', { name: 'Last name', exact: true }); }
  get email() { return this.page.getByRole('textbox', { name: 'Email', exact: true }); }
  get phone() { return this.page.getByRole('textbox', { name: 'Phone', exact: true }); }
  get age() { return this.page.getByRole('spinbutton', { name: 'Age', exact: true }); }
  get gender() { return this.page.getByRole('combobox', { name: 'Gender', exact: true }); }
  get password() { return this.page.getByRole('textbox', { name: 'Password', exact: true }); }
  get confirmPassword() { return this.page.getByRole('textbox', { name: 'Confirm password', exact: true }); }
  get acceptTerms() { return this.page.getByRole('checkbox', { name: 'I accept the terms', exact: true }); }
  get createAccountButton() { return this.page.getByRole('button', { name: 'Create account', exact: true }); }

  async getFieldByLabel(label: string): Promise<Locator> {
    switch (label) {
      case 'First name':
        return this.firstName;
      case 'Last name':
        return this.lastName;
      case 'Email':
        return this.email;
      case 'Phone':
        return this.phone;
      case 'Age':
        return this.age;
      case 'Gender':
        return this.gender;
      case 'Password':
        return this.password;
      case 'Confirm password':
        return this.confirmPassword;
      case 'I accept the terms':
        return this.acceptTerms;
      default:
        throw new Error(`Field with label "${label}" not found on RegisterPage.`);
    }
  }
}
