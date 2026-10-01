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
}
