Security Policy
===============

Reporting a Vulnerability
-------------------------

Please do not open public issues for security concerns. Email the maintainers privately.

Supported Versions
------------------

- Main branch is supported. Use the latest release for security fixes.

Best Practices in This Repo
---------------------------

- Apex code enforces CRUD/FLS in critical flows
- CI runs static analysis and org-based tests
- Tests should not use `SeeAllData=true` unless unavoidable (e.g., ConnectApi)
