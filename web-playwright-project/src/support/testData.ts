import { readFileSync } from 'fs';
import { requireEnv } from './config.js';
import { resolveTokens } from './testDataGenerator.js';

// Loads src/testdata/<name>.json, resolving two kinds of placeholder inside string values:
// - "${APP_PASSWORD}": from the environment, so credentials stay out of the repo. An unset or
//   empty variable fails here, by name, instead of failing later as a confusing app error.
// - "{{random.email}}" (also {{negative.x}}, {{boundary.x}}, {{security.x}}): a value
//   generated fresh on every call -- see testDataGenerator.ts.
export function loadTestData<T = Record<string, any>>(name: string): T {
  const raw = readFileSync(new URL(`../testdata/${name}.json`, import.meta.url), 'utf8');
  const withEnv = raw.replace(/\$\{(\w+)\}/g, (_, key) => JSON.stringify(requireEnv(key)).slice(1, -1));
  return resolveAll(JSON.parse(withEnv));
}

function resolveAll(value: any): any {
  if (typeof value === 'string') return resolveTokens(value);
  if (Array.isArray(value)) return value.map(resolveAll);
  if (value && typeof value === 'object') {
    return Object.fromEntries(Object.entries(value).map(([k, v]) => [k, resolveAll(v)]));
  }
  return value;
}
