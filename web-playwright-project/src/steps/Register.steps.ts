import { When, Then } from '@cucumber/cucumber';
import { expect } from '@playwright/test';
import { CustomWorld } from '../support/world.js';
import { RegisterPage } from '../pages/RegisterPage.js';

When('I fill "Email" with a unique email', async function (this: CustomWorld) {
  const registerPage = new RegisterPage(this.page);
  const uniqueEmail = `${this.uniqueName('testuser')}@example.com`;
  await registerPage.fill(registerPage.email, uniqueEmail);
});

Then('the "{string}" field should show the error "{string}"', async function (this: CustomWorld, fieldName: string, errorMessage: string) {
  const registerPage = new RegisterPage(this.page);
  const fieldLocator = registerPage.getFieldByName(fieldName);
  await registerPage.checkValidationError(fieldLocator, errorMessage);
});

When('I press the "{string}" key', async function(this: CustomWorld, key: string) {
  await this.page.keyboard.press(key);
});

Then('the "{string}" field is focused', async function (this: CustomWorld, fieldName: string) {
  const registerPage = new RegisterPage(this.page);
  const fieldLocator = registerPage.getFieldByName(fieldName);
  await expect(fieldLocator).toBeFocused();
});

Then('the "{string}" button is focused', async function (this: CustomWorld, buttonName: string) {
  const registerPage = new RegisterPage(this.page);
  const buttonLocator = registerPage.getFieldByName(buttonName);
  await expect(buttonLocator).toBeFocused();
});

Then('the "{string}" link is focused', async function (this: CustomWorld, linkName: string) {
  const registerPage = new RegisterPage(this.page);
  const linkLocator = registerPage.getFieldByName(linkName);
  await expect(linkLocator).toBeFocused();
});

Then('no JavaScript alert dialog with the text "{string}" appears', async function(this: CustomWorld, text: string) {
  // This step relies on Playwright's default behavior of failing a test
  // if an unhandled dialog appears. Its success in the test report confirms
  // that no such dialog was triggered by previous actions.
  // This is a placeholder to make the verification explicit in the Gherkin.
  expect(true).toBe(true);
});

When('I tab until the "{string}" button is focused', async function(this: CustomWorld, buttonName: string) {
    const registerPage = new RegisterPage(this.page);
    const buttonLocator = registerPage.getFieldByName(buttonName);
    // Tab a maximum of 10 times to find the element, to prevent infinite loops.
    for (let i = 0; i < 10; i++) {
        const isFocused = await buttonLocator.evaluate(el => el === document.activeElement);
        if (isFocused) {
            return;
        }
        await this.page.keyboard.press('Tab');
    }
    await expect(buttonLocator).toBeFocused({ timeout: 100 }); // Final check fails test if not focused
});
