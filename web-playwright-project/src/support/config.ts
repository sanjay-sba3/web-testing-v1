import dotenv from 'dotenv';

dotenv.config();

// Every environment-specific value (base URL, credentials) comes from .env / process env --
// never hardcode one in a feature, step, page object or test data file.
export const config = {
  baseUrl: process.env.APP_BASE_URL ?? '',
  username: process.env.APP_USERNAME ?? '',
  password: process.env.APP_PASSWORD ?? '',
  browser: (process.env.BROWSER ?? 'chromium').toLowerCase(),
  headless: process.env.HEADLESS !== 'false',
  timeout: Number(process.env.STEP_TIMEOUT_MS ?? 60000)
};
