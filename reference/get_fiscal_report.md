# Get Fiscal Management Report (RGF) – English interface

English-parameter alias for
[`get_rgf()`](https://strategicprojects.github.io/siconfir/reference/get_rgf.md).
See that function for full details on return values and API behavior.

## Usage

``` r
get_fiscal_report(
  fiscal_year,
  periodicity,
  period,
  report_type,
  appendix,
  sphere,
  branch,
  entity_id,
  use_cache = TRUE
)
```

## Arguments

- fiscal_year:

  Integer. Fiscal year (e.g., `2022`). Maps to `an_exercicio`.

- periodicity:

  Character. `"Q"` (four-monthly) or `"S"` (semi-annual). Maps to
  `in_periodicidade`.

- period:

  Integer. Period number (1–3 for four-monthly, 1–2 for semi-annual).
  Maps to `nr_periodo`.

- report_type:

  Character. `"RGF"` or `"RGF Simplificado"`. Maps to
  `co_tipo_demonstrativo`.

- appendix:

  Character. Appendix name (e.g., `"RGF-Anexo 01"`). Maps to `no_anexo`.

- sphere:

  Character. Government sphere: `"M"`, `"E"`, or `"U"`. Maps to
  `co_esfera`.

- branch:

  Character. Government branch: `"E"` (executive), `"L"` (legislative),
  `"J"` (judiciary), `"M"` (public ministry), `"D"` (public defender).
  Maps to `co_poder`.

- entity_id:

  Integer. IBGE code of the entity. Maps to `id_ente`.

- use_cache:

  Logical. If `TRUE` (default), uses an in-memory cache.

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble.html) with RGF
data.

## See also

[`get_rgf()`](https://strategicprojects.github.io/siconfir/reference/get_rgf.md)
for the original Portuguese-parameter interface.

## Examples

``` r
if (FALSE) { # \dontrun{
rgf <- get_fiscal_report(
  fiscal_year = 2022, periodicity = "Q", period = 3,
  report_type = "RGF", appendix = "RGF-Anexo 01",
  sphere = "E", branch = "E", entity_id = 17
)
} # }
```
