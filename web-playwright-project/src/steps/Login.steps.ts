import { When, Then, Before } from '@cucumber/cucumber';
import { expect } from '@playwright/test';
import { CustomWorld } from '../support/world.js';
import { loadTestData } from '../support/testData.js';
import { LoginPage } from '../pages/LoginPage.js';
import { DashboardPage } from '../pages/DashboardPage.js';

let testData: any;

Before(async () => {
  testData = await loadTestData('Login');
});

let dialogOccurred = false;

Before({ tags: '@xss-check' }, function (this: CustomWorld) {
  dialogOccurred = false;
  this.page.once('dialog', dialog => {
    dialogOccurred = true;
    dialog.dismiss().catch(() => {});
  });
});

When('I login with credentials from "{string}"', async function (this: CustomWorld, dataKey: string) {
  const credentials = testData[dataKey];
  const loginPage = new LoginPage(this.page);
  if (credentials.email !== undefined) {
    await loginPage.fill(loginPage.email, credentials.email);
  }
  if (credentials.password !== undefined) {
    await loginPage.fill(loginPage.password, credentials.password);
  }
  await loginPage.click(loginPage.signIn);
});

When('I press the "{string}" key', async function (this: CustomWorld, key: string) {
  await this.page.keyboard.press(key);
});

Then('I should see the "{string}" field', async function (this: CustomWorld, fieldName: string) {
  const loginPage = new LoginPage(this.page);
  switch (fieldName.toLowerCase()) {
    case 'email':
      await expect(loginPage.email).toBeVisible();
      break;
    case 'password':
      await expect(loginPage.password).toBeVisible();
      break;
    default:
      throw new Error(`Field "${fieldName}" is not defined on the Login page.`);
  }
});

Then('the "{string}" field should show the error "{string}"', async function (this: CustomWorld, fieldName: string, message: string) {
  const loginPage = new LoginPage(this.page);
  let element;
  switch (fieldName.toLowerCase()) {
    case 'email':
      element = loginPage.email;
      break;
    case 'password':
      element = loginPage.password;
      break;
    default:
      throw new Error(`Field "${fieldName}" is not defined on the Login page.`);
  }
  const validationMessage = await element.evaluate(e => (e as HTMLInputElement).validationMessage);
  expect(validationMessage).toBe(message);
});

Then('no javascript alert should be present', async function (this: CustomWorld) {
  await this.page.evaluate(() => {}); // Give a micro-task tick for event to propagate
  expect(dialogOccurred).toBe(false);
});

Then('the "{string}" {word} is focused', async function (this: CustomWorld, name: string, type: string) {
  const loginPage = new LoginPage(this.page);
  let locator;
  if (type === 'field') {
    switch(name.toLowerCase()) {
        case 'email': locator = loginPage.email; break;
        case 'password': locator = loginPage.password; break;
    }
  } else if (type === 'button') {
     if(name.toLowerCase() === 'sign in') {
        locator = loginPage.signIn;
     }
  }
  
  if (!locator) {
    throw new Error(`Element with name "${name}" and type "${type}" not found.`);
  }

  await expect(locator).toBeFocused();
});
