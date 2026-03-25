# Get Budget Execution Summary Report data (RREO)

Retrieves data from the Budget Execution Summary Report (RREO) for
specific filtering criteria. The RREO is published bimonthly and
contains information about revenues, expenses, and other budgetary data.

## Usage

``` r
get_rreo(
  an_exercicio,
  nr_periodo,
  co_tipo_demonstrativo,
  no_anexo,
  co_esfera,
  id_ente,
  use_cache = TRUE
)
```

## Arguments

- an_exercicio:

  Integer. Fiscal year (e.g., `2022`). **Required**.

- nr_periodo:

  Integer. Bimester number (1-6). **Required**.

- co_tipo_demonstrativo:

  Character. Report type: `"RREO"` or `"RREO Simplificado"`.
  **Required**.

- no_anexo:

  Character. Appendix name (e.g., `"RREO-Anexo 01"`). **Required**.

- co_esfera:

  Character. Government sphere: `"M"` (municipalities), `"E"` (states),
  or `"U"` (union). **Required**.

- id_ente:

  Integer. IBGE code of the entity. **Required**.

- use_cache:

  Logical. If `TRUE` (default), uses an in-memory cache.

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble.html) with RREO
data including columns such as `exercicio`, `demonstrativo`, `periodo`,
`periodicidade`, `instituicao`, `cod_ibge`, `uf`, `populacao`, `anexo`,
`rotulo`, `coluna`, `cod_conta`, `conta`, and `valor`.

## Details

[`get_budget_report()`](https://strategicprojects.github.io/siconfir/reference/get_budget_report.md)
is an English-parameter alias for this function.

## Examples

``` r
if (FALSE) { # \dontrun{
rreo <- get_rreo(
  an_exercicio = 2022, nr_periodo = 6,
  co_tipo_demonstrativo = "RREO",
  no_anexo = "RREO-Anexo 01",
  co_esfera = "E", id_ente = 17
)
} # }
```
