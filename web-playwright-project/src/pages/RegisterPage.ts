import { BasePage } from './BasePage.js';
import { expect } from '@playwright/test';

export class RegisterPage extends BasePage {
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

  async open() {
    await super.open('http://localhost:3000/register');
    await expect(this.createAccountButton).toBeVisible();
  }

  async register(givenName: string, familyName: string, email: string, age: string, gender: string, password: string, acceptTerms: boolean) {
    await this.fill(this.givenName, givenName);
    await this.fill(this.familyName, familyName);
    await this.fill(this.emailAddress, email);
    await this.fill(this.age, age);
    await this.select(this.genderIdentity, gender);
    await this.fill(this.accountPassword, password);
    await this.fill(this.confirmPassword, password);
    if (acceptTerms) {
      await this.check(this.termsAndConditions);
    }
    await this.click(this.createAccountButton);
  }
}