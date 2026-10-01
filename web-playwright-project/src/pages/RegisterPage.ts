import { Locator, Page } from '@playwright/test';
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

  get acceptTermsCheckbox(): Locator {
    return this.page.getByRole('checkbox', { name: 'I accept the terms and conditions', exact: true });
  }

  get createAccountButton(): Locator {
    return this.page.getByRole('button', { name: 'Create account', exact: true });
  }

  async register(
    givenName: string,
    familyName: string,
    email: string,
    age: string,
    gender: string,
    password: string
  ): Promise<void> {
    await this.fill(this.givenName, givenName);
    await this.fill(this.familyName, familyName);
    await this.fill(this.emailAddress, email);
    await this.fill(this.age, age);
    await this.genderIdentity.selectOption(gender);
    await this.fill(this.accountPassword, password);
    await this.fill(this.confirmPassword, password);
    await this.check(this.acceptTermsCheckbox);
    await this.click(this.createAccountButton);
  }
}
