import { BasePage } from './BasePage.js';

export class RegistrationConfirmationPage extends BasePage {
  // TODO: Locator inferred, not from a captured DOM snapshot.

  get successMessage() { return this.page.getByText('Registration successful!'); }
}
