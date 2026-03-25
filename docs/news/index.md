# Changelog

## siconfir 0.1.0

- Initial CRAN release.
- Added
  [`get_anexos()`](https://strategicprojects.github.io/siconfir/reference/get_anexos.md)
  for report appendix reference table.
- Added
  [`get_entes()`](https://strategicprojects.github.io/siconfir/reference/get_entes.md)
  for government entities listing.
- Added
  [`get_dca()`](https://strategicprojects.github.io/siconfir/reference/get_dca.md)
  for Annual Accounts Declaration data.
- Added
  [`get_extrato()`](https://strategicprojects.github.io/siconfir/reference/get_extrato.md)
  for delivery status extract.
- Added
  [`get_rreo()`](https://strategicprojects.github.io/siconfir/reference/get_rreo.md)
  for Budget Execution Summary Report data.
- Added
  [`get_rgf()`](https://strategicprojects.github.io/siconfir/reference/get_rgf.md)
  for Fiscal Management Report data.
- Added
  [`get_msc_controle()`](https://strategicprojects.github.io/siconfir/reference/get_msc_controle.md)
  for MSC control accounts (classes 7-8).
- Added
  [`get_msc_orcamentaria()`](https://strategicprojects.github.io/siconfir/reference/get_msc_orcamentaria.md)
  for MSC budgetary accounts (classes 5-6).
- Added
  [`get_msc_patrimonial()`](https://strategicprojects.github.io/siconfir/reference/get_msc_patrimonial.md)
  for MSC equity/asset accounts (classes 1-4).
- English aliases with English parameter names:
  [`get_entities()`](https://strategicprojects.github.io/siconfir/reference/get_entes.md),
  [`get_annexes()`](https://strategicprojects.github.io/siconfir/reference/get_anexos.md),
  [`get_annual_accounts()`](https://strategicprojects.github.io/siconfir/reference/get_annual_accounts.md),
  [`get_delivery_status()`](https://strategicprojects.github.io/siconfir/reference/get_delivery_status.md),
  [`get_budget_report()`](https://strategicprojects.github.io/siconfir/reference/get_budget_report.md),
  [`get_fiscal_report()`](https://strategicprojects.github.io/siconfir/reference/get_fiscal_report.md),
  [`get_msc_control()`](https://strategicprojects.github.io/siconfir/reference/get_msc_control.md),
  [`get_msc_budget()`](https://strategicprojects.github.io/siconfir/reference/get_msc_budget.md),
  [`get_msc_equity()`](https://strategicprojects.github.io/siconfir/reference/get_msc_equity.md).
- All functions return tibbles.
- Automatic pagination to fetch all pages of results.
- In-memory session cache with
  [`siconfir_clear_cache()`](https://strategicprojects.github.io/siconfir/reference/siconfir_clear_cache.md).
- Built on [httr2](https://httr2.r-lib.org) with automatic retries and
  informative error messages.
- Informative CLI messages via [cli](https://cli.r-lib.org).
