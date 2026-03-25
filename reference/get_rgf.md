# Get Fiscal Management Report data (RGF)

Retrieves data from the Fiscal Management Report (RGF) for specific
filtering criteria. The RGF contains information about personnel
expenses, debt, credit operations, and other fiscal indicators.

## Usage

``` r
get_rgf(
  an_exercicio,
  in_periodicidade,
  nr_periodo,
  co_tipo_demonstrativo,
  no_anexo,
  co_esfera,
  co_poder,
  id_ente,
  use_cache = TRUE
)
```

## Arguments

- an_exercicio:

  Integer. Fiscal year (e.g., `2022`). **Required**.

- in_periodicidade:

  Character. Periodicity: `"Q"` (four-monthly) or `"S"` (semi-annual,
  only for simplified RGF). **Required**.

- nr_periodo:

  Integer. Period number (1-3 for four-monthly, 1-2 for semi-annual).
  **Required**.

- co_tipo_demonstrativo:

  Character. Report type: `"RGF"` or `"RGF Simplificado"`. **Required**.

- no_anexo:

  Character. Appendix name (e.g., `"RGF-Anexo 01"`). **Required**.

- co_esfera:

  Character. Government sphere: `"M"` (municipalities), `"E"` (states),
  or `"U"` (union). **Required**.

- co_poder:

  Character. Government branch: `"E"` (executive), `"L"` (legislative),
  `"J"` (judiciary), `"M"` (public ministry), `"D"` (public defender).
  **Required**.

- id_ente:

  Integer. IBGE code of the entity. **Required**.

- use_cache:

  Logical. If `TRUE` (default), uses an in-memory cache.

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble.html) with RGF
data including columns such as `exercicio`, `periodo`, `periodicidade`,
`instituicao`, `cod_ibge`, `uf`, `co_poder`, `populacao`, `anexo`,
`rotulo`, `coluna`, `cod_conta`, `conta`, and `valor`.

## Details

[`get_fiscal_report()`](https://strategicprojects.github.io/siconfir/reference/get_fiscal_report.md)
is an English-parameter alias for this function.

## Examples

``` r
if (FALSE) { # \dontrun{
rgf <- get_rgf(
  an_exercicio = 2022, in_periodicidade = "Q", nr_periodo = 3,
  co_tipo_demonstrativo = "RGF", no_anexo = "RGF-Anexo 01",
  co_esfera = "E", co_poder = "E", id_ente = 17
)
} # }
```
