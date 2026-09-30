import { Given, When, Then } from '@cucumber/cucumber';
import { expect } from '@playwright/test';
import { CustomWorld } from '../support/world.js';

// Shared, page-agnostic steps. Generated feature files reuse these by exact text; a
// feature's own <Name>.steps.ts only adds what these can't express.

const escapeRegExp = (s: string) => s.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');

Given('I open the {string} page', async function (this: CustomWorld, url: string) {
  await this.page.goto(url);
});

When('I click the {string} button', async function (this: CustomWorld, name: string) {
  await this.page.getByRole('button', { name }).click();
});

When('I click the {string} link', async function (this: CustomWorld, name: string) {
  await this.page.getByRole('link', { name }).click();
});

When('I fill {string} with {string}', async function (this: CustomWorld, label: string, value: string) {
  await this.page.getByLabel(label).fill(value);
});

When('I fill {string} with the value of env {string}', async function (this: CustomWorld, label: string, envKey: string) {
  const value = process.env[envKey];
  if (value === undefined) throw new Error(`Environment variable ${envKey} is not set (see .env.example)`);
  await this.page.getByLabel(label).fill(value);
});

Then('I should see the text {string}', async function (this: CustomWorld, text: string) {
  await expect(this.page.getByText(text).first()).toBeVisible();
});

Then('I should not see the text {string}', async function (this: CustomWorld, text: string) {
  await expect(this.page.getByText(text)).toHaveCount(0);
});

Then('I should see the {string} button', async function (this: CustomWorld, name: string) {
  await expect(this.page.getByRole('button', { name })).toBeVisible();
});

Then('the page title should contain {string}', async function (this: CustomWorld, text: string) {
  await expect(this.page).toHaveTitle(new RegExp(escapeRegExp(text)));
});

Then('the URL should contain {string}', async function (this: CustomWorld, text: string) {
  await expect(this.page).toHaveURL(new RegExp(escapeRegExp(text)));
});
