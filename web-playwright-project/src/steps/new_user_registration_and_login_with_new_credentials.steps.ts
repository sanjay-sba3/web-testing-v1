import { CustomWorld } from '../support/world.js';
import { RegisterPage } from '../pages/RegisterPage.js';
import { LoginPage } from '../pages/LoginPage.js';
import { loadTestData } from '../support/testData.js';
import { When, Then } from '@cucumber/cucumber';

When('I register a new user', async function (this: CustomWorld) {
  const registerPage = new RegisterPage(this.page);
  const testData = loadTestData('new_user_registration_and_login_with_new_credentials');
  
  await registerPage.open('/register');
  await registerPage.fill(registerPage.givenName, testData.firstName);
  await registerPage.fill(registerPage.familyName, testData.lastName);
  await registerPage.fill(registerPage.emailAddress, testData.email);
  await registerPage.fill(registerPage.accountPassword, testData.password);
  await registerPage.fill(registerPage.confirmPassword, testData.confirmPassword);
  await registerPage.select(registerPage.genderIdentity, 'Male');
  await registerPage.fill(registerPage.ageYears, '30');
  await registerPage.check(registerPage.acceptTerms);
  await registerPage.click(registerPage.createAccount);
});

When('I sign in as that new user', async function (this: CustomWorld) {
  const loginPage = new LoginPage(this.page);
  const testData = loadTestData('new_user_registration_and_login_with_new_credentials');
  
  await loginPage.open('/login');
  await loginPage.fill(loginPage.email, testData.email);
  await loginPage.fill(loginPage.password, testData.password);
  await loginPage.click(loginPage.signIn);
});