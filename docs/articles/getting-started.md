# Getting Started with siconfir

## What is siconfir?

**siconfir** is an R package that provides direct access to fiscal data
from [SICONFI](https://siconfi.tesouro.gov.br/) (Accounting and Fiscal
Information System for the Brazilian Public Sector) through the
Brazilian National Treasury’s API.

It allows you to query data from all Brazilian states and
municipalities, including fiscal reports such as RREO, RGF, DCA, and the
Accounting Balances Matrix (MSC).

## Installation

``` r

# Install from CRAN (when available)
install.packages("siconfir")

# Or the development version from GitHub
# install.packages("pak")
pak::pak("StrategicProjects/siconfir")
```

## Basic queries

### Function names and English aliases

Every function is available in two forms: an English interface with
English parameter names, and a Portuguese interface matching the
original API parameter names. Both produce identical results – use
whichever you prefer:

| English function | Portuguese function |
|----|----|
| [`get_entities()`](https://strategicprojects.github.io/siconfir/reference/get_entes.md) | [`get_entes()`](https://strategicprojects.github.io/siconfir/reference/get_entes.md) |
| [`get_annexes()`](https://strategicprojects.github.io/siconfir/reference/get_anexos.md) | [`get_anexos()`](https://strategicprojects.github.io/siconfir/reference/get_anexos.md) |
| [`get_annual_accounts()`](https://strategicprojects.github.io/siconfir/reference/get_annual_accounts.md) | [`get_dca()`](https://strategicprojects.github.io/siconfir/reference/get_dca.md) |
| [`get_delivery_status()`](https://strategicprojects.github.io/siconfir/reference/get_delivery_status.md) | [`get_extrato()`](https://strategicprojects.github.io/siconfir/reference/get_extrato.md) |
| [`get_budget_report()`](https://strategicprojects.github.io/siconfir/reference/get_budget_report.md) | [`get_rreo()`](https://strategicprojects.github.io/siconfir/reference/get_rreo.md) |
| [`get_fiscal_report()`](https://strategicprojects.github.io/siconfir/reference/get_fiscal_report.md) | [`get_rgf()`](https://strategicprojects.github.io/siconfir/reference/get_rgf.md) |
| [`get_msc_equity()`](https://strategicprojects.github.io/siconfir/reference/get_msc_equity.md) | [`get_msc_patrimonial()`](https://strategicprojects.github.io/siconfir/reference/get_msc_patrimonial.md) |
| [`get_msc_budget()`](https://strategicprojects.github.io/siconfir/reference/get_msc_budget.md) | [`get_msc_orcamentaria()`](https://strategicprojects.github.io/siconfir/reference/get_msc_orcamentaria.md) |
| [`get_msc_control()`](https://strategicprojects.github.io/siconfir/reference/get_msc_control.md) | [`get_msc_controle()`](https://strategicprojects.github.io/siconfir/reference/get_msc_controle.md) |

The English functions also translate the **parameter names**. For
example, `fiscal_year` maps to `an_exercicio`, `entity_id` to `id_ente`,
and so on. See each function’s help page for the full mapping.

Note that while function and parameter *names* are in English, some
parameter *values* must still be in Portuguese because they come from
the API itself (e.g., `appendix = "RREO-Anexo 01"`).

### List government entities

The most common starting point is to list the available entities. You
will need the IBGE code (`cod_ibge`) for all other queries.

``` r

library(siconfir)
library(dplyr)

entes <- get_entities()
entes
```

You can filter by state, region, or government sphere:

``` r

# State capitals
capitals <- entes |>
  filter(capital == 1)

# Municipalities in the state of Pernambuco
municipalities_pe <- entes |>
  filter(uf == "PE", esfera == "M")
```

### Query the RREO (Budget Execution Summary Report)

The RREO is published bimonthly. Use
[`get_budget_report()`](https://strategicprojects.github.io/siconfir/reference/get_budget_report.md)
(or
[`get_rreo()`](https://strategicprojects.github.io/siconfir/reference/get_rreo.md)):

``` r

rreo <- get_budget_report(
  fiscal_year = 2023,
  period      = 6,
  report_type = "RREO",
  appendix    = "RREO-Anexo 01",
  sphere      = "E",
  entity_id   = 26 # Pernambuco
)
```

### Query the RGF (Fiscal Management Report)

The RGF is published every four months:

``` r

rgf <- get_fiscal_report(
  fiscal_year = 2023,
  periodicity = "Q",
  period      = 3,
  report_type = "RGF",
  appendix    = "RGF-Anexo 01",
  sphere      = "E",
  branch      = "E",
  entity_id   = 26
)
```

### Query the DCA (Annual Accounts Declaration)

The DCA contains annual balance sheet data:

``` r

dca <- get_annual_accounts(fiscal_year = 2023, entity_id = 26)
```

### Check delivery status

To find out which reports an entity has submitted:

``` r

status <- get_delivery_status(entity_id = 26, year = 2023)
```

### Query the MSC (Accounting Balances Matrix)

The MSC provides detailed accounting data, split into three segments:
equity/assets (classes 1–4), budgetary (5–6), and control (7–8).

``` r

# Equity/asset accounts
msc_equity <- get_msc_equity(
  entity_id     = 26,
  year          = 2023,
  month         = 12,
  matrix_type   = "MSCC",
  account_class = 1,
  value_type    = "ending_balance"
)

# Budgetary accounts
msc_budget <- get_msc_budget(
  entity_id     = 26,
  year          = 2023,
  month         = 12,
  matrix_type   = "MSCC",
  account_class = 6,
  value_type    = "period_change"
)
```

## Caching

The package maintains an in-memory cache for the duration of the R
session. If you call the same function with the same parameters, data
will be returned from the cache without hitting the API again.

To clear the cache:

``` r

siconfir_clear_cache()
```

You can also disable the cache for a specific call:

``` r

entes <- get_entes(use_cache = FALSE)
```

## Pagination

The SICONFI API returns a maximum of 5,000 rows per page. **siconfir**
handles pagination automatically, following the `hasMore` / `offset`
pattern until all data has been retrieved. Informative messages indicate
how many pages were fetched and how many rows were returned.

## Report appendices reference table

Use
[`get_anexos()`](https://strategicprojects.github.io/siconfir/reference/get_anexos.md)
to query the reference table listing all available appendices by report
type and government sphere:

``` r

anexos <- get_anexos()

# Appendices available for the municipal RREO
anexos |>
  filter(esfera == "M", str_detect(anexo, "RREO"))
```

## Further information

- [SICONFI API
  documentation](https://apidatalake.tesouro.gov.br/docs/siconfi/)
- [SICONFI website](https://siconfi.tesouro.gov.br/)
