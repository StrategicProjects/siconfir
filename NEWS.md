# siconfir 0.1.0

* Initial CRAN release.
* Added `get_anexos()` for report appendix reference table.
* Added `get_entes()` for government entities listing.
* Added `get_dca()` for Annual Accounts Declaration data.
* Added `get_extrato()` for delivery status extract.
* Added `get_rreo()` for Budget Execution Summary Report data.
* Added `get_rgf()` for Fiscal Management Report data.
* Added `get_msc_controle()` for MSC control accounts (classes 7-8).
* Added `get_msc_orcamentaria()` for MSC budgetary accounts (classes 5-6).
* Added `get_msc_patrimonial()` for MSC equity/asset accounts (classes 1-4).
* English aliases with English parameter names: `get_entities()`,
  `get_annexes()`, `get_annual_accounts()`, `get_delivery_status()`,
  `get_budget_report()`, `get_fiscal_report()`, `get_msc_control()`,
  `get_msc_budget()`, `get_msc_equity()`.
* All functions return tibbles.
* Automatic pagination to fetch all pages of results.
* In-memory session cache with `siconfir_clear_cache()`.
* Built on `{httr2}` with automatic retries.
* Informative CLI messages via `{cli}`.
