# Get report appendix reference table

Retrieves the reference table of report appendices (anexos) grouped by
government sphere. This is a support table that describes which
appendices are available for each report type (RREO, RGF, DCA, etc.).

## Usage

``` r
get_annexes(use_cache = TRUE)

get_anexos(use_cache = TRUE)
```

## Arguments

- use_cache:

  Logical. If `TRUE` (default), uses an in-memory cache to avoid
  repeated requests within the same session.

## Value

A [tibble](https://tibble.tidyverse.org/reference/tibble.html) with
columns:

- esfera:

  Government sphere: `"U"` (Union), `"E"` (States), `"M"`
  (Municipalities).

- demonstrativo:

  Report type (e.g., `"RREO"`, `"RGF"`, `"DCA"`).

- anexo:

  Appendix name (e.g., `"RREO-Anexo 01"`).

## Details

`get_annexes()` is an English alias for `get_anexos()`.

## Examples

``` r
if (FALSE) { # \dontrun{
anexos <- get_anexos()
} # }
```
