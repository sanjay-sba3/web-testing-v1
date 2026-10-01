import { Then } from '@cucumber/cucumber';
import { expect } from '@playwright/test';
import type { Page, Locator } from '@playwright/test';
import { CustomWorld } from '../support/world.js';

Then('the {string} field should be masked', async function (this: CustomWorld, label: string) {
    const locator = this.page.getByRole('textbox', { name: label, exact: true });
    await expect(locator).toHaveAttribute('type', 'password');
});

Then('the {string} {string} should be focused', async function (this: CustomWorld, label: string, role: 'button' | 'checkbox' | 'combobox' | 'link' | 'textbox' | 'spinbutton') {
    const element = this.page.getByRole(role, { name: label, exact: true });
    await expect(element).toBeFocused();
});
