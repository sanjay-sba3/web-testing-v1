import { BasePage } from './BasePage.js';

export class RegistrationPage extends BasePage {
  getHeading(name: string) {
    return this.page.getByRole('heading', { name, exact: true });
  }

  get givenName() { return this.page.getByRole('textbox', { name: 'Given name', exact: true }); }
  get familyName() { return this.page.getByRole('textbox', { name: 'Family name', exact: true }); }
  get emailAddress() { return this.page.getByRole('textbox', { name: 'Email address', exact: true }); }
  get mobileNumber() { return this.page.getByRole('textbox', { name: 'Mobile number', exact: true }); }
  get age() { return this.page.getByRole('spinbutton', { name: 'Age (years)', exact: true }); }
  get genderIdentity() { return this.page.getByRole('combobox', { name: 'Gender identity', exact: true }); }
  get accountPassword() { return this.page.getByRole('textbox', { name: 'Account password', exact: true }); }
  get confirmPassword() { return this.page.getByRole('textbox', { name: 'Confirm password', exact: true }); }
  get termsAndConditionsCheckbox() { return this.page.getByRole('checkbox', { name: 'I accept the terms and conditions', exact: true }); }
  get createAccountButton() { return this.page.getByRole('button', { name: 'Create account', exact: true }); }
  get loginLink() { return this.page.getByRole('link', { name: 'Login', exact: true }); }
}