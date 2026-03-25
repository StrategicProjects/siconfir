# Get list of Brazilian government entities

Retrieves the complete list of government entities (entes) registered in
the SICONFI system, including states, municipalities, and the Federal
District.

## Usage

``` r
get_entities(use_cache = TRUE)

get_entes(use_cache = TRUE)
```

## Arguments

- use_cache:

  Logical. If `TRUE` (default), uses an in-memory cache.

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble.html) with
columns:

- cod_ibge:

  IBGE code of the entity.

- ente:

  Name of the entity.

- capital:

  Whether the municipality is a state capital (1 = yes, 0 = no).

- regiao:

  Geographic region (`"SU"`, `"NE"`, `"NO"`, `"SE"`, `"CO"`, `"BR"`).

- uf:

  State abbreviation.

- esfera:

  Government sphere: `"M"`, `"E"`, `"U"`, `"D"`.

- an_exercicio:

  Year of the population data.

- populacao:

  Estimated population.

- co_cnpj:

  CNPJ of the entity.

## Details

`get_entities()` is an English alias for `get_entes()`.

## Examples

``` r
if (FALSE) { # \dontrun{
entes <- get_entes()
} # }
```
