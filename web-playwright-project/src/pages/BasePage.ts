import { expect, Page, Locator } from '@playwright/test';

// Every page object extends this. Locators are declared on the subclass as getters built
// from getByRole/getByLabel/getByText/getByTestId -- CSS only as a last resort, never XPath.
export class BasePage {
  protected readonly page: Page;

  constructor(page: Page) {
    this.page = page;
  }

  // Absolute URL, or a path resolved against APP_BASE_URL.
  async open(url: string): Promise<void> {
    await this.page.goto(url);
  }

  async click(locator: Locator): Promise<void> {
    await locator.click();
  }

  async fill(locator: Locator, value: string): Promise<void> {
    await locator.fill(value);
  }

  async expectVisible(locator: Locator): Promise<void> {
    await expect(locator).toBeVisible();
  }

  // For records the app requires to be unique (names, emails) -- fresh on every run.
  uniqueName(prefix: string): string {
    return `${prefix}_${Date.now()}_${Math.floor(Math.random() * 10000)}`;
  }
}
