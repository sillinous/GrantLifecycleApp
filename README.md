Grant Lifecycle Application
=================

As part of a Force for Change grant from the [Salesforce Foundation](http://www.salesforcefoundation.org), [Bridge Farm Consulting](http://www.bridgefarmconsulting.com/) helped the [Center for American Progress](http://www.americanprogress.org/) to build a new application to help them manage the grants they receive from Foundations. 

The code is freely available to Non profits to use and update. 

ToDo:
*Add Description/Commentary to Budget/Actual Classes

You can install the Unmanaged Package using [this link] (https://login.salesforce.com/packaging/installPackage.apexp?p0=04ti0000000PSsk)

You'll find lots of documentation about how to use the package in Grant Lifecycle Chatter Group in the [Power of Us Hub](https://powerofus.force.com/_ui/core/chatter/groups/GroupProfilePage?g=0F980000000CncZ)

Modern install options
----------------------

- SFDX (recommended): Convert MDAPI `src/` to SFDX and deploy to a scratch/sandbox org.
  - Prereqs: Salesforce CLI installed, org auth available.
  - Steps:
    1. Convert locally: `sf project convert mdapi -r src -d force-app`
    2. Authorize org: `sf org login web -a MySandbox`
    3. Deploy source: `sf project deploy start -d force-app -o MySandbox`
    4. Run tests: `sf apex run test -o MySandbox`

- Legacy MDAPI: Use Workbench or ANT to deploy the `src/` folder with `package.xml`.

CI
--

- This repo includes a GitHub Actions workflow at `.github/workflows/validate.yml` running PMD rules against `src/classes`. Extend to add org-based validation and tests as needed.
