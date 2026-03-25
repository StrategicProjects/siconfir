# Get delivery status extract – English interface

English-parameter alias for
[`get_extrato()`](https://strategicprojects.github.io/siconfir/reference/get_extrato.md).
See that function for full details on return values and API behavior.

## Usage

``` r
get_delivery_status(entity_id, year, use_cache = TRUE)
```

## Arguments

- entity_id:

  Integer. IBGE code of the entity. Maps to `id_ente`.

- year:

  Integer. Reference year (e.g., `2022`). Maps to `an_referencia`.

- use_cache:

  Logical. If `TRUE` (default), uses an in-memory cache.

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble.html) with
delivery status data.

## See also

[`get_extrato()`](https://strategicprojects.github.io/siconfir/reference/get_extrato.md)
for the original Portuguese-parameter interface.

## Examples

``` r
if (FALSE) { # \dontrun{
status <- get_delivery_status(entity_id = 17, year = 2022)
} # }
```
