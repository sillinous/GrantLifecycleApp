Technical follow-ups
====================

- Tests using SeeAllData
  - Replace SeeAllData=true by creating explicit test records via factories
  - Stub/mimic ConnectApi where possible

- CRUD/FLS enforcement
  - Add Security.stripInaccessible for query/update paths
  - Check object CRUD and field-level access before DML

- Modernize project
  - Convert MDAPI src/ to SFDX source format and add sfdx-project.json
  - Bump metadata API version (package.xml is 29.0)

- CI/CD
  - Extend GitHub Actions to run org-based validation and Apex tests
  - Add sfdx-scanner rules and coverage thresholds

