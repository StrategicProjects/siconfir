# Get Budget Execution Summary Report (RREO) – English interface

English-parameter alias for
[`get_rreo()`](https://strategicprojects.github.io/siconfir/reference/get_rreo.md).
See that function for full details on return values and API behavior.

## Usage

``` r
get_budget_report(
  fiscal_year,
  period,
  report_type,
  appendix,
  sphere,
  entity_id,
  use_cache = TRUE
)
```

## Arguments

- fiscal_year:

  Integer. Fiscal year (e.g., `2022`). Maps to `an_exercicio`.

- period:

  Integer. Bimester number (1–6). Maps to `nr_periodo`.

- report_type:

  Character. `"RREO"` or `"RREO Simplificado"`. Maps to
  `co_tipo_demonstrativo`.

- appendix:

  Character. Appendix name (e.g., `"RREO-Anexo 01"`). Maps to
  `no_anexo`.

- sphere:

  Character. Government sphere: `"M"` (municipalities), `"E"` (states),
  or `"U"` (union). Maps to `co_esfera`.

- entity_id:

  Integer. IBGE code of the entity. Maps to `id_ente`.

- use_cache:

  Logical. If `TRUE` (default), uses an in-memory cache.

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble.html) with RREO
data.

## See also

[`get_rreo()`](https://strategicprojects.github.io/siconfir/reference/get_rreo.md)
for the original Portuguese-parameter interface.

## Examples

``` r
if (FALSE) { # \dontrun{
rreo <- get_budget_report(
  fiscal_year = 2022, period = 6,
  report_type = "RREO",
  appendix = "RREO-Anexo 01",
  sphere = "E", entity_id = 17
)
} # }
```
