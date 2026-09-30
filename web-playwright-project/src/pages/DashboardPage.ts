import { BasePage } from './BasePage.js';

export class DashboardPage extends BasePage {
  get logoutButton() {
    // TODO: not in captured DOM
    return this.page.getByRole('button', { name: 'Logout' });
  }
}
