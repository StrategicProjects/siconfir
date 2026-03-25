# Get annual accounts data (DCA)

Retrieves data from the Annual Accounts Declaration (DCA) or the legacy
QDCC for a specific entity and fiscal year.

## Usage

``` r
get_dca(an_exercicio, id_ente, no_anexo = NULL, use_cache = TRUE)
```

## Arguments

- an_exercicio:

  Integer. Fiscal year (e.g., `2022`). **Required**.

- id_ente:

  Integer. IBGE code of the entity. **Required**.

- no_anexo:

  Character. Appendix name filter (e.g., `"DCA-Anexo I-AB"`). Optional.

- use_cache:

  Logical. If `TRUE` (default), uses an in-memory cache.

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble.html) with
DCA/QDCC data including columns such as `exercicio`, `instituicao`,
`cod_ibge`, `uf`, `anexo`, `rotulo`, `coluna`, `cod_conta`, `conta`,
`valor`, and `populacao`.

## Details

[`get_annual_accounts()`](https://strategicprojects.github.io/siconfir/reference/get_annual_accounts.md)
is an English alias for `get_dca()`.

## Examples

``` r
if (FALSE) { # \dontrun{
# DCA data for the state of Tocantins in 2022
dca <- get_dca(an_exercicio = 2022, id_ente = 17)
} # }
```
