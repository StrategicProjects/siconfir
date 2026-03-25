# Get delivery status extract

Retrieves the extract of report deliveries for a given entity and
reference year. Useful for checking which reports have been submitted
and their status (approved, rectified, etc.).

## Usage

``` r
get_extrato(id_ente, an_referencia, use_cache = TRUE)
```

## Arguments

- id_ente:

  Integer. IBGE code of the entity. **Required**.

- an_referencia:

  Integer. Reference year (e.g., `2022`). **Required**.

- use_cache:

  Logical. If `TRUE` (default), uses an in-memory cache.

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble.html) with
delivery status data including columns such as `exercicio`, `cod_ibge`,
`instituicao`, `entregavel`, `periodo`, `periodicidade`,
`status_relatorio`, `data_status`, `forma_envio`, and `tipo_relatorio`.

## Details

[`get_delivery_status()`](https://strategicprojects.github.io/siconfir/reference/get_delivery_status.md)
is an English alias for `get_extrato()`.

## Examples

``` r
if (FALSE) { # \dontrun{
extrato <- get_extrato(id_ente = 17, an_referencia = 2022)
} # }
```
