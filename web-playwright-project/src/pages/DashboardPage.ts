import { BasePage } from './BasePage.js';

export class DashboardPage extends BasePage {
  get logoutButton() {
    // TODO: not in captured DOM. Assuming standard role and name for logout functionality.
    return this.page.getByRole('button', { name: 'Logout' });
  }
}
