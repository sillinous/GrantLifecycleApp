import { test, expect } from '@playwright/test';

const ORG_BASE = process.env.SF_ORG_BASE as string; // e.g., https://mydomain.my.salesforce.com
const USERNAME = process.env.SF_USERNAME as string;
const PASSWORD = process.env.SF_PASSWORD as string;
const PROJECT_ID = process.env.E2E_PROJECT_ID as string; // seeded via script

test('Budget vs Actual page loads and shows headings', async ({ page }) => {
  test.skip(!ORG_BASE || !USERNAME || !PASSWORD || !PROJECT_ID, 'Org creds and project id required');

  await page.goto(`${ORG_BASE}/secur/login.jsp`);
  await page.fill('#username', USERNAME);
  await page.fill('#password', PASSWORD);
  await page.click('#Login');

  await page.goto(`${ORG_BASE}/apex/BudgetvsActual?id=${PROJECT_ID}`);
  await expect(page.getByText('Budget vs. Actual').or(page.getByText('Year-to-Date'))).toBeVisible();
  await expect(page.getByText('Personnel')).toBeVisible();
  await expect(page.getByText('Program Expenditures')).toBeVisible();
});

