# Get annual accounts data (DCA) – English interface

English-parameter alias for
[`get_dca()`](https://strategicprojects.github.io/siconfir/reference/get_dca.md).
See that function for full details on return values and API behavior.

## Usage

``` r
get_annual_accounts(fiscal_year, entity_id, appendix = NULL, use_cache = TRUE)
```

## Arguments

- fiscal_year:

  Integer. Fiscal year (e.g., `2022`). Maps to `an_exercicio`.

- entity_id:

  Integer. IBGE code of the entity. Maps to `id_ente`.

- appendix:

  Character. Appendix name filter (e.g., `"DCA-Anexo I-AB"`). Optional.
  Maps to `no_anexo`.

- use_cache:

  Logical. If `TRUE` (default), uses an in-memory cache.

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble.html) with DCA
data.

## See also

[`get_dca()`](https://strategicprojects.github.io/siconfir/reference/get_dca.md)
for the original Portuguese-parameter interface.

## Examples

``` r
if (FALSE) { # \dontrun{
dca <- get_annual_accounts(fiscal_year = 2022, entity_id = 17)
} # }
```
