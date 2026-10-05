import { BasePage } from './BasePage.js';

export class LoginPage extends BasePage {
  get email() { return this.page.getByRole('textbox', { name: 'Email', exact: true }); }
  get password() { return this.page.getByRole('textbox', { name: 'Password', exact: true }); }
  get signIn() { return this.page.getByRole('button', { name: 'Sign in', exact: true }); }

  async login(email: string, password: string): Promise<void> {
    await this.fill(this.email, email);
    await this.fill(this.password, password);
    await this.click(this.signIn);
  }
}
