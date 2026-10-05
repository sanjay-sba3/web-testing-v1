import { BasePage } from './BasePage.js';

export class RegisterPage extends BasePage {
  get givenName() { return this.page.getByRole('textbox', { name: 'Given name', exact: true }); }
  get familyName() { return this.page.getByRole('textbox', { name: 'Family name', exact: true }); }
  get emailAddress() { return this.page.getByRole('textbox', { name: 'Email address', exact: true }); }
  get mobileNumber() { return this.page.getByRole('textbox', { name: 'Mobile number', exact: true }); }
  get age() { return this.page.getByRole('spinbutton', { name: 'Age (years)', exact: true }); }
  get genderIdentity() { return this.page.getByRole('combobox', { name: 'Gender identity', exact: true }); }
  get accountPassword() { return this.page.getByRole('textbox', { name: 'Account password', exact: true }); }
  get confirmPassword() { return this.page.getByRole('textbox', { name: 'Confirm password', exact: true }); }
  get terms() { return this.page.getByRole('checkbox', { name: 'I accept the terms and conditions', exact: true }); }
  get createAccount() { return this.page.getByRole('button', { name: 'Create account', exact: true }); }

  async register(details: {
    givenName: string;
    familyName: string;
    email: string;
    mobile: string;
    age: string;
    gender: string;
    password: string;
  }): Promise<void> {
    await this.fill(this.givenName, details.givenName);
    await this.fill(this.familyName, details.familyName);
    await this.fill(this.emailAddress, details.email);
    await this.fill(this.mobileNumber, details.mobile);
    await this.fill(this.age, details.age);
    await this.select(this.genderIdentity, details.gender);
    await this.fill(this.accountPassword, details.password);
    await this.fill(this.confirmPassword, details.password);
    await this.check(this.terms);
    await this.click(this.createAccount);
  }
}
