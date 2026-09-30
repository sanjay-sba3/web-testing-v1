import { When, Then } from '@cucumber/cucumber';
import { expect } from '@playwright/test';
import { CustomWorld } from '../support/world.js';
import { loadTestData } from '../support/testData.js';
import { generateValue } from '../support/testDataGenerator.js';
import { RegisterPage } from '../pages/RegisterPage.js';

type TestData = { [key: string]: string };

When('I fill "{string}" with test data "{string}"', async function (this: CustomWorld, label: string, key: string) {
  const testData = await loadTestData<TestData>('Register');
  const value = testData[key];
  await this.page.getByLabel(label).fill(value);
});

When('I fill "{string}" with a security script and save it as "{string}"', async function (this: CustomWorld, label: string, contextKey: string) {
  const value = generateValue(label, 'security');
  this[contextKey] = value;
  await this.page.getByLabel(label).fill(value);
});

Then('the "{string}" field should be visible', async function (this: CustomWorld, label: string) {
  const registerPage = new RegisterPage(this.page);
  await expect(registerPage.getFieldByLabel(label)).toBeVisible();
});

Then('the "{string}" field should be masked', async function (this: CustomWorld, label: string) {
  const registerPage = new RegisterPage(this.page);
  await expect(registerPage.getFieldByLabel(label)).toHaveAttribute('type', 'password');
});

Then('the "{string}" checkbox should be invalid', async function (this: CustomWorld, label: string) {
  const registerPage = new RegisterPage(this.page);
  const checkbox = registerPage.getFieldByLabel(label);
  const validationMessage = await checkbox.evaluate(e => (e as HTMLInputElement).validationMessage);
  expect(validationMessage).not.toBe('');
});

Then('the "{string}" field should have the value of context variable "{string}"', async function (this: CustomWorld, label: string, contextKey: string) {
  const registerPage = new RegisterPage(this.page);
  const expectedValue = this[contextKey] as string;
  await expect(registerPage.getFieldByLabel(label)).toHaveValue(expectedValue);
});

Then('the focus should be on the "{string}" field', async function (this: CustomWorld, label: string) {
  await expect(this.page.getByLabel(label)).toBeFocused();
});

Then('the focus should be on the "{string}" spinbutton', async function (this: CustomWorld, name: string) {
  await expect(this.page.getByRole('spinbutton', { name })).toBeFocused();
});

Then('the focus should be on the "{string}" combobox', async function (this: CustomWorld, name: string) {
  await expect(this.page.getByRole('combobox', { name })).toBeFocused();
});

Then('the focus should be on the "{string}" checkbox', async function (this: CustomWorld, name: string) {
  await expect(this.page.getByRole('checkbox', { name })).toBeFocused();
});

Then('the focus should be on the "{string}" button', async function (this: CustomWorld, name: string) {
  await expect(this.page.getByRole('button', { name })).toBeFocused();
});

Then('the focus should be on the "{string}" link', async function (this: CustomWorld, name: string) {
  await expect(this.page.getByRole('link', { name })).toBeFocused();
});
