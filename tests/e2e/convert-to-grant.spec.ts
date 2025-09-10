import { test, expect } from '@playwright/test';

const ORG_BASE = process.env.SF_ORG_BASE as string;
const USERNAME = process.env.SF_USERNAME as string;
const PASSWORD = process.env.SF_PASSWORD as string;
const OPP_ID = process.env.E2E_OPPORTUNITY_ID as string; // seeded via script

test('Convert to Grant page renders and Save and Continue works', async ({ page }) => {
  test.skip(!ORG_BASE || !USERNAME || !PASSWORD || !OPP_ID, 'Org creds and opp id required');

  await page.goto(`${ORG_BASE}/secur/login.jsp`);
  await page.fill('#username', USERNAME);
  await page.fill('#password', PASSWORD);
  await page.click('#Login');

  await page.goto(`${ORG_BASE}/apex/ConvertToGrantRecord?id=${OPP_ID}`);
  await expect(page.getByText('Setup New Grant')).toBeVisible();
  await page.getByRole('button', { name: 'Save and Continue' }).click();
  await expect(page).toHaveURL(new RegExp('/apex/GrantWizardP2\?id='));
});

