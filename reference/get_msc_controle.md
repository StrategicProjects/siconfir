# Get MSC control accounts data

Retrieves control accounts data (classes 7 and 8) from the Accounting
Balances Matrix (MSC) for a specific entity, year, month, and matrix
type.

## Usage

``` r
get_msc_controle(
  id_ente,
  an_referencia,
  me_referencia,
  co_tipo_matriz,
  classe_conta,
  id_tv,
  use_cache = TRUE
)
```

## Arguments

- id_ente:

  Integer. IBGE code of the entity. **Required**.

- an_referencia:

  Integer. Reference year. **Required**.

- me_referencia:

  Integer. Reference month (1-12). **Required**.

- co_tipo_matriz:

  Character. Matrix type: `"MSCC"` (monthly aggregate) or `"MSCE"`
  (annual closing). **Required**.

- classe_conta:

  Integer. Account class: `7` or `8`. **Required**.

- id_tv:

  Character. Value type: `"beginning_balance"`, `"ending_balance"`, or
  `"period_change"`. **Required**.

- use_cache:

  Logical. If `TRUE` (default), uses an in-memory cache.

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble.html) with MSC
control account data.

## Details

[`get_msc_control()`](https://strategicprojects.github.io/siconfir/reference/get_msc_control.md)
is an English alias for `get_msc_controle()`.

## Examples

``` r
if (FALSE) { # \dontrun{
msc_ctrl <- get_msc_controle(
  id_ente = 17, an_referencia = 2022, me_referencia = 12,
  co_tipo_matriz = "MSCC", classe_conta = 8,
  id_tv = "ending_balance"
)
} # }
```
