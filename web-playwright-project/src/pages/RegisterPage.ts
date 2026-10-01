import { BasePage } from './BasePage.js';
import type { Locator, Page } from '@playwright/test';

export class RegisterPage extends BasePage {
  constructor(page: Page) {
    super(page);
  }

  get givenName() { return this.page.getByRole('textbox', { name: 'Given name', exact: true }); }
  get familyName() { return this.page.getByRole('textbox', { name: 'Family name', exact: true }); }
  get emailAddress() { return this.page.getByRole('textbox', { name: 'Email address', exact: true }); }
  get mobileNumber() { return this.page.getByRole('textbox', { name: 'Mobile number', exact: true }); }
  get age() { return this.page.getByRole('spinbutton', { name: 'Age (years)', exact: true }); }
  get genderIdentity() { return this.page.getByRole('combobox', { name: 'Gender identity', exact: true }); }
  get accountPassword() { return this.page.getByRole('textbox', { name: 'Account password', exact: true }); }
  get confirmPassword() { return this.page.getByRole('textbox', { name: 'Confirm password', exact: true }); }
  get termsAndConditions() { return this.page.getByRole('checkbox', { name: 'I accept the terms and conditions', exact: true }); }
  get createAccountButton() { return this.page.getByRole('button', { name: 'Create account', exact: true }); }
  get loginLink() { return this.page.getByRole('link', { name: 'Login', exact: true }); }

  public getElementByName(name: string): Locator {
    switch (name) {
      case 'Given name':
        return this.givenName;
      case 'Family name':
        return this.familyName;
      case 'Email address':
        return this.emailAddress;
      case 'Mobile number':
        return this.mobileNumber;
      case 'Age (years)':
        return this.age;
      case 'Gender identity':
        return this.genderIdentity;
      case 'Account password':
        return this.accountPassword;
      case 'Confirm password':
        return this.confirmPassword;
      case 'I accept the terms and conditions':
        return this.termsAndConditions;
      case 'Create account':
        return this.createAccountButton;
      case 'Login':
        return this.loginLink;
      default:
        throw new Error(`Element with name "${name}" not found on RegisterPage.`);
    }
  }
}
