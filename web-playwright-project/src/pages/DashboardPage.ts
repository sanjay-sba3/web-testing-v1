import { BasePage } from './BasePage.js';

export class DashboardPage extends BasePage {
  // TODO: not in captured DOM
  get logoutButton() { return this.page.getByRole('button', { name: 'Logout' }); }
}
