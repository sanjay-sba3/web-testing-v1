import { When } from '@cucumber/cucumber';
import { CustomWorld } from '../support/world.js';
import { generateValue } from '../support/testDataGenerator.js';
import { RegisterPage } from '../pages/RegisterPage.js';
import { LoginPage } from '../pages/LoginPage.js';

type JourneyWorld = CustomWorld & { email?: string; password?: string };

When('I register a new user', async function (this: JourneyWorld) {
  const registerPage = new RegisterPage(this.page);
  this.email = generateValue('email');
  this.password = 'Secret123';
  
  await registerPage.open('/register');
  await registerPage.fill(registerPage.givenName, 'John');
  await registerPage.fill(registerPage.familyName, 'Doe');
  await registerPage.fill(registerPage.emailAddress, this.email);
  await registerPage.fill(registerPage.accountPassword, this.password);
  await registerPage.fill(registerPage.confirmPassword, this.password);
  await registerPage.select(registerPage.genderIdentity, 'Male');
  await registerPage.fill(registerPage.age, '30');
  await registerPage.check(registerPage.terms);
  await registerPage.click(registerPage.createAccount);
});

When('I open the {string} page', async function (this: CustomWorld, url: string) {
  const page = new LoginPage(this.page);
  await page.open(url);
});