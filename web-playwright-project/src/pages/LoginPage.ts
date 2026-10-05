import { BasePage } from './BasePage.js';

export class LoginPage extends BasePage {
  get email() { return this.page.getByRole('textbox', { name: 'Email', exact: true }); }
  get password() { return this.page.getByRole('textbox', { name: 'Password', exact: true }); }
  get signIn() { return this.page.getByRole('button', { name: 'Sign in', exact: true }); }
  get registerNow() { return this.page.getByRole('link', { name: 'Register now', exact: true }); }

  async login(user: string, pass: string): Promise<void> {
    await this.fill(this.email, user);
    await this.fill(this.password, pass);
    await this.click(this.signIn);
  }
}