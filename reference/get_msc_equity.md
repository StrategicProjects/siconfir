# Get MSC equity/asset accounts – English interface

English-parameter alias for
[`get_msc_patrimonial()`](https://strategicprojects.github.io/siconfir/reference/get_msc_patrimonial.md).
See that function for full details on return values and API behavior.

## Usage

``` r
get_msc_equity(
  entity_id,
  year,
  month,
  matrix_type,
  account_class,
  value_type,
  use_cache = TRUE
)
```

## Arguments

- entity_id:

  Integer. IBGE code of the entity. Maps to `id_ente`.

- year:

  Integer. Reference year. Maps to `an_referencia`.

- month:

  Integer. Reference month (1–12). Maps to `me_referencia`.

- matrix_type:

  Character. `"MSCC"` (monthly) or `"MSCE"` (annual closing). Maps to
  `co_tipo_matriz`.

- account_class:

  Integer. Account class: `1`, `2`, `3`, or `4`. Maps to `classe_conta`.

- value_type:

  Character. `"beginning_balance"`, `"ending_balance"`, or
  `"period_change"`. Maps to `id_tv`.

- use_cache:

  Logical. If `TRUE` (default), uses an in-memory cache.

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble.html) with MSC
equity/asset account data.

## See also

[`get_msc_patrimonial()`](https://strategicprojects.github.io/siconfir/reference/get_msc_patrimonial.md)
for the original Portuguese-parameter interface.

## Examples

``` r
if (FALSE) { # \dontrun{
msc <- get_msc_equity(
  entity_id = 17, year = 2022, month = 12,
  matrix_type = "MSCC", account_class = 1,
  value_type = "ending_balance"
)
} # }
```
