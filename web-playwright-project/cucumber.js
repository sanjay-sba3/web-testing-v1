export default {
  paths: ['src/features/**/*.feature'],
  import: ['src/support/**/*.ts', 'src/steps/**/*.ts'],
  loader: ['ts-node/esm'],
  format: [
    'progress',
    'json:reports/cucumber-report.json',
    'html:reports/cucumber-report.html',
    'allure-cucumberjs/reporter'
  ],
  formatOptions: { resultsDir: 'allure-results' },
  failFast: false
};
