import { readFileSync } from 'fs';

// Loads src/testdata/<name>.json. "${VAR}" placeholders are replaced from process.env, so
// credentials stay in .env: {"password": "${APP_PASSWORD}"}. An unset variable fails here,
// by name, instead of silently becoming "" and failing later as a confusing app error.
export function loadTestData<T = Record<string, any>>(name: string): T {
  const raw = readFileSync(new URL(`../testdata/${name}.json`, import.meta.url), 'utf8');
  const resolved = raw.replace(/\$\{(\w+)\}/g, (_, key) => {
    const value = process.env[key];
    if (value === undefined) throw new Error(`Environment variable ${key} is not set (see .env.example)`);
    return JSON.stringify(value).slice(1, -1);
  });
  return JSON.parse(resolved);
}
