import { BasePage } from './BasePage.js';
import { expect } from '@playwright/test';

export interface RegistrationData {
  firstName: string;
  lastName: string;
  email: string;
  password: string;
  confirmPassword: string;
  gender: string;
  age: string;
}

export class RegistrationPage extends BasePage {
  get firstName() { return this.page.getByRole('textbox', { name: 'First name', exact: true }); }
  get lastName() { return this.page.getByRole('textbox', { name: 'Last name', exact: true }); }
  get emailAddress() { return this.page.getByRole('textbox', { name: 'Email address', exact: true }); }
  get mobileNumber() { return this.page.getByRole('textbox', { name: 'Mobile number', exact: true }); }
  get ageYears() { return this.page.getByRole('spinbutton', { name: 'Age (years)', exact: true }); }
  get genderIdentity() { return this.page.getByRole('combobox', { name: 'Gender identity', exact: true }); }
  get accountPassword() { return this.page.getByRole('textbox', { name: 'Account password', exact: true }); }
  get confirmPassword() { return this.page.getByRole('textbox', { name: 'Confirm password', exact: true }); }
  get termsAndConditions() { return this.page.getByRole('checkbox', { name: 'I accept the terms and conditions', exact: true }); }
  get createAccount() { return this.page.getByRole('button', { name: 'Create account', exact: true }); }
  get signInLink() { return this.page.getByRole('link', { name: 'Sign in', exact: true }); }

  async fillRegistrationForm(data: RegistrationData) {
    await this.fill(this.firstName, data.firstName);
    await this.fill(this.lastName, data.lastName);
    await this.fill(this.emailAddress, data.email);
    await this.fill(this.accountPassword, data.password);
    await this.fill(this.confirmPassword, data.confirmPassword);
    await this.select(this.genderIdentity, data.gender);
    await this.fill(this.ageYears, data.age);
  }

  async acceptTerms() {
    await this.check(this.termsAndConditions);
  }

  async submitRegistration() {
    await this.click(this.createAccount);
  }

  async isRegistrationSuccessful() {
    // This would need to be implemented based on how success is indicated
    // For example, checking for a specific message or URL change
    return this.page.getByText('Registration successful').isVisible();
  }
}