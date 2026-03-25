
# siconfir <img src="man/figures/logo.png" align="right" height="139" />

<!-- badges: start -->
[![R-CMD-check](https://github.com/StrategicProjects/siconfir/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/StrategicProjects/siconfir/actions/workflows/R-CMD-check.yaml)
[![CRAN status](https://www.r-pkg.org/badges/version/siconfir)](https://CRAN.R-project.org/package=siconfir)
<!-- badges: end -->

**siconfir** provides a tidy, modern interface to the [SICONFI API](https://apidatalake.tesouro.gov.br/docs/siconfi/) from Brazil's National Treasury (Secretaria do Tesouro Nacional). It lets you access fiscal data from all Brazilian states and municipalities directly from R.

<table class="important-banner"><tr><td>
&#x2755; <strong class="important-title">Disclaimer</strong><br>
This package acts as a wrapper for a Brazilian public API provided by the
Secretaria do Tesouro Nacional (STN), which is the institution responsible for
the data. To maintain consistency with R package development standards, all
wrapper functions are available with English names and English parameter names.
However, because the source API is natively in Portuguese, some
<strong>parameter values</strong> must still be passed in Portuguese (e.g.,
<code>report_type = "RREO Simplificado"</code>,
<code>appendix = "RREO-Anexo 01"</code>), and <strong>response column
names</strong> are in Portuguese (e.g., <code>cod_ibge</code>,
<code>exercicio</code>, <code>valor</code>). For example: you may use
<code>get_budget_report()</code>, but you need to pass values like
<code>appendix = "RREO-Anexo 01"</code>. The original Portuguese-named
functions (e.g., <code>get_rreo(an_exercicio = 2022)</code>) are also fully
supported. You can find the original list of endpoints and their respective
parameters in the
<a href="https://apidatalake.tesouro.gov.br/docs/siconfi/">official API
documentation</a>.
</td></tr></table>

## Installation

```r
# Install from CRAN (when available)
install.packages("siconfir")

# Or install the development version from GitHub
# install.packages("pak")
pak::pak("StrategicProjects/siconfir")
```

## Features

- **Tidyverse-friendly**: All functions return tibbles with snake_case column names.
- **Automatic pagination**: Fetches all pages of results transparently.
- **In-memory caching**: Avoids redundant API calls within the same session.
- **Informative messages**: Uses `{cli}` for clear progress and error messages.
- **Modern HTTP**: Built on `{httr2}` with automatic retries.

## Available Functions

All functions return [tibbles](https://tibble.tidyverse.org/). English aliases
with English parameter names are provided for all functions.

| Function | English Alias | Endpoint | Description |
|---|---|---|---|
| `get_anexos()` | `get_annexes()` | `/anexos-relatorios` | Report appendix reference table |
| `get_entes()` | `get_entities()` | `/entes` | Government entities (states, municipalities) |
| `get_dca()` | `get_annual_accounts()` | `/dca` | Annual Accounts Declaration (DCA) |
| `get_extrato()` | `get_delivery_status()` | `/extrato_entregas` | Delivery status extract |
| `get_rreo()` | `get_budget_report()` | `/rreo` | Budget Execution Summary Report (RREO) |
| `get_rgf()` | `get_fiscal_report()` | `/rgf` | Fiscal Management Report (RGF) |
| `get_msc_controle()` | `get_msc_control()` | `/msc_controle` | MSC control accounts (classes 7-8) |
| `get_msc_orcamentaria()` | `get_msc_budget()` | `/msc_orcamentaria` | MSC budgetary accounts (classes 5-6) |
| `get_msc_patrimonial()` | `get_msc_equity()` | `/msc_patrimonial` | MSC equity/asset accounts (classes 1-4) |

## Quick Start

```r
library(siconfir)

# List all entities
entes <- get_entities()

# Budget Execution Summary (RREO) -- English interface
rreo <- get_budget_report(
  fiscal_year = 2022, period = 6,
  report_type = "RREO", appendix = "RREO-Anexo 01",
  sphere = "E", entity_id = 17  # Tocantins
)

# Same call using the Portuguese interface:
# rreo <- get_rreo(
#   an_exercicio = 2022, nr_periodo = 6,
#   co_tipo_demonstrativo = "RREO", no_anexo = "RREO-Anexo 01",
#   co_esfera = "E", id_ente = 17
# )

# Fiscal Management Report (RGF) for Sao Paulo city
rgf <- get_fiscal_report(
  fiscal_year = 2022, periodicity = "Q", period = 3,
  report_type = "RGF", appendix = "RGF-Anexo 01",
  sphere = "M", branch = "E", entity_id = 3550308
)

# Annual accounts for Rondonia
dca <- get_annual_accounts(fiscal_year = 2022, entity_id = 11)

# Clear the cache if needed
siconfir_clear_cache()
```

## API Reference

The SICONFI API is provided by the Brazilian National Treasury at:

```
https://apidatalake.tesouro.gov.br/ords/siconfi/tt/
```

The API returns up to 5,000 rows per page. **siconfir** handles pagination automatically, following the `hasMore` / `offset` pattern until all data is retrieved.

**Rate limit**: The API allows one request per second. The package uses `httr2::req_retry()` to handle transient errors gracefully.

## License
MIT
