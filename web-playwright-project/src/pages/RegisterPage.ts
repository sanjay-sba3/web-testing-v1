import { Locator } from '@playwright/test';
import { BasePage } from './BasePage.js';

export class RegisterPage extends BasePage {
  get givenName(): Locator {
    return this.page.getByRole('textbox', { name: 'Given name', exact: true });
  }

  get familyName(): Locator {
    return this.page.getByRole('textbox', { name: 'Family name', exact: true });
  }

  get emailAddress(): Locator {
    return this.page.getByRole('textbox', { name: 'Email address', exact: true });
  }

  get mobileNumber(): Locator {
    return this.page.getByRole('textbox', { name: 'Mobile number', exact: true });
  }

  get age(): Locator {
    return this.page.getByRole('spinbutton', { name: 'Age (years)', exact: true });
  }

  get genderIdentity(): Locator {
    return this.page.getByRole('combobox', { name: 'Gender identity', exact: true });
  }

  get accountPassword(): Locator {
    return this.page.getByRole('textbox', { name: 'Account password', exact: true });
  }

  get confirmPassword(): Locator {
    return this.page.getByRole('textbox', { name: 'Confirm password', exact: true });
  }

  get acceptTerms(): Locator {
    return this.page.getByRole('checkbox', { name: 'I accept the terms and conditions', exact: true });
  }

  get createAccount(): Locator {
    return this.page.getByRole('button', { name: 'Create account', exact: true });
  }
}