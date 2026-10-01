import { faker } from '@faker-js/faker';

// Web counterpart of the API project's TestDataGenerator.java + RandomTokenResolver.java --
// same field-name heuristics and the same four strategies, so a web and an API test for the
// same feature use the same kind of data. Values are generated when the test RUNS, never
// baked in at generation time, so unique fields (email, username) never collide between runs.

// 'random' is the same as 'positive' -- it's the name the {{random.x}} token uses, so a
// step written as generateValue('email', 'random') works too.
export type Strategy = 'positive' | 'random' | 'negative' | 'boundary' | 'security';

const NUMERIC_KEY = /^id$|id$|count$|quantity|amount|number|age/;

function isNumericHint(key: string, hint?: string): boolean {
  if (hint === 'number') return true;
  if (hint === 'boolean') return false;
  if (hint !== undefined && hint !== '' && !Number.isNaN(Number(hint))) return true;
  return NUMERIC_KEY.test(key);
}

// `field` is the data's name ("email", "firstName", "quantity"); `hint` is an optional type
// ("number" | "boolean" | "string"), as in the API project's `| field | typeHint |` tables.
// Always a string: every generated value ends up typed into a field (fill() takes a string).
export function generateValue(field: string, strategy: Strategy = 'positive', hint?: string): string {
  return String(rawValue(field, strategy, hint));
}

function rawValue(field: string, strategy: Strategy, hint?: string): string | number | boolean {
  const key = field.toLowerCase();
  const isBoolean = hint === 'boolean';
  const isNumeric = !isBoolean && isNumericHint(key, hint);

  switch (strategy) {
    case 'positive':
    case 'random':
      if (key.includes('email')) return faker.internet.email();
      if (key.includes('password')) return 'Pass@' + faker.internet.password({ length: 10 });
      if (key.includes('user') || key.includes('name')) return faker.internet.username();
      if (key.includes('date')) return new Date().toISOString();
      if (isBoolean) return faker.datatype.boolean();
      if (isNumeric) return faker.number.int({ min: 1, max: 100 });
      return faker.lorem.word();
    case 'negative':
      if (key.includes('email')) return 'invalid-email';
      if (key.includes('password')) return '';
      return isNumeric ? -999 : '';
    case 'boundary':
      return isNumeric ? 0 : 'A';
    case 'security':
      // A web page renders input, so the script payload is the useful probe here (XSS);
      // the API project's SQL-injection string stays available as field "sql".
      if (key.includes('sql')) return "' OR '1'='1";
      return isNumeric ? 9999999 : '<script>alert(1)</script>';
  }
  // Never return undefined: a fill(undefined) fails far from the real cause ("expected string,
  // got undefined"). TypeScript runs with strict off here, so an unknown name can reach this.
  throw new Error(`Unknown test data strategy "${strategy}" -- use positive (or random), negative, boundary or security`);
}

const TOKEN = /\{\{(random|negative|boundary|security)\.([A-Za-z0-9_]+)\}\}/g;
const STRATEGY: Record<string, Strategy> = { random: 'positive', negative: 'negative', boundary: 'boundary', security: 'security' };

// Replaces every {{random.email}} / {{negative.email}} / {{boundary.name}} / {{security.comment}}
// token with a freshly generated value -- each occurrence gets its OWN value, exactly like the
// API project's {{random.field}}. Used by the shared steps and by loadTestData.
export function resolveTokens(text: string): string {
  return text.replace(TOKEN, (_, kind: string, field: string) => generateValue(field, STRATEGY[kind]));
}
