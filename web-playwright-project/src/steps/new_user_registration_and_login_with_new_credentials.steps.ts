import { CustomWorld } from '../support/world.js';
import { Then } from '@cucumber/cucumber';

Then('I should see the {string} link', async function (this: CustomWorld, linkText: string) {
  const link = this.page.getByRole('link', { name: linkText, exact: true });
  await link.waitFor({ state: 'visible' });
});