import { When, Then } from '@cucumber/cucumber';
import { expect } from '@playwright/test';
import { CustomWorld } from '../support/world.js';
import { RegisterPage } from '../pages/RegisterPage.js';
import { resolveTokens } from '../support/testDataGenerator.js';

Then('the "{string}" field should be a password field', async function (this: CustomWorld, label: string) {
    const registerPage = new RegisterPage(this.page);
    const field = registerPage.getLocatorByLabel(label);
    await expect(field).toHaveAttribute('type', 'password');
});

Then('the "{string}" field should be focused', async function (this: CustomWorld, label: string) {
    const registerPage = new RegisterPage(this.page);
    const field = registerPage.getLocatorByLabel(label);
    await expect(field).toBeFocused();
});

Then('the "{string}" button should be focused', async function (this: CustomWorld, label: string) {
    const registerPage = new RegisterPage(this.page);
    const field = registerPage.getLocatorByLabel(label);
    await expect(field).toBeFocused();
});

When('I click the text label for "{string}"', async function (this: CustomWorld, label: string) {
    await this.page.getByText(label, { exact: true }).first().click();
});

Then('the "{string}" field should have value "{string}"', async function (this: CustomWorld, label: string, value: string) {
    const registerPage = new RegisterPage(this.page);
    const field = registerPage.getLocatorByLabel(label);
    const expectedValue = await resolveTokens(value, this);
    await expect(field).toHaveValue(expectedValue);
});
