import { When, Then } from '@cucumber/cucumber';
import { CustomWorld } from '../support/world.js';
import { generateValue } from '../support/testDataGenerator.js';
import { LoginPage } from '../pages/LoginPage.js';
import { RegisterPage } from '../pages/RegisterPage.js';

type JourneyWorld = CustomWorld & { email?: string; password?: string };

When('I register a new user', async function (this: JourneyWorld) {
  const registerPage = new RegisterPage(this.page);
  this.email = generateValue('email');
  this.password = 'SecurePass123!';
  
  await registerPage.open('/register');
  await registerPage.fill(registerPage.givenName, 'Test');
  await registerPage.fill(registerPage.familyName, 'User');
  await registerPage.fill(registerPage.email, this.email);
  await registerPage.fill(registerPage.age, '25');
  await registerPage.select(registerPage.gender, 'Male');
  await registerPage.fill(registerPage.password, this.password);
  await registerPage.fill(registerPage.confirmPassword, this.password);
  await registerPage.check(registerPage.terms);
  await registerPage.click(registerPage.createAccount);
});