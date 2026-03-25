#' Get Fiscal Management Report data (RGF)
#'
#' Retrieves data from the Fiscal Management Report (RGF) for specific
#' filtering criteria. The RGF contains information
#' about personnel expenses, debt, credit operations, and other fiscal
#' indicators.
#'
#' `get_fiscal_report()` is an English-parameter alias for this function.
#'
#' @param an_exercicio Integer. Fiscal year (e.g., `2022`). **Required**.
#' @param in_periodicidade Character. Periodicity: `"Q"` (four-monthly) or
#'   `"S"` (semi-annual, only for simplified RGF). **Required**.
#' @param nr_periodo Integer. Period number (1-3 for four-monthly, 1-2 for
#'   semi-annual). **Required**.
#' @param co_tipo_demonstrativo Character. Report type: `"RGF"` or
#'   `"RGF Simplificado"`. **Required**.
#' @param no_anexo Character. Appendix name (e.g., `"RGF-Anexo 01"`).
#'   **Required**.
#' @param co_esfera Character. Government sphere: `"M"` (municipalities),
#'   `"E"` (states), or `"U"` (union). **Required**.
#' @param co_poder Character. Government branch: `"E"` (executive),
#'   `"L"` (legislative), `"J"` (judiciary), `"M"` (public ministry),
#'   `"D"` (public defender). **Required**.
#' @param id_ente Integer. IBGE code of the entity. **Required**.
#' @param use_cache Logical. If `TRUE` (default), uses an in-memory cache.
#'
#' @return A [tibble][tibble::tibble] with RGF data including columns such as
#'   `exercicio`, `periodo`, `periodicidade`, `instituicao`, `cod_ibge`, `uf`,
#'   `co_poder`, `populacao`, `anexo`, `rotulo`, `coluna`, `cod_conta`,
#'   `conta`, and `valor`.
#'
#' @export
#' @examples
#' \dontrun{
#' rgf <- get_rgf(
#'   an_exercicio = 2022, in_periodicidade = "Q", nr_periodo = 3,
#'   co_tipo_demonstrativo = "RGF", no_anexo = "RGF-Anexo 01",
#'   co_esfera = "E", co_poder = "E", id_ente = 17
#' )
#' }
get_rgf <- function(an_exercicio, in_periodicidade, nr_periodo,
                    co_tipo_demonstrativo, no_anexo, co_esfera,
                    co_poder, id_ente, use_cache = TRUE) {
  check_required(
    an_exercicio, in_periodicidade, nr_periodo,
    co_tipo_demonstrativo, no_anexo, co_esfera,
    co_poder, id_ente
  )

  params <- list(
    an_exercicio          = an_exercicio,
    in_periodicidade      = in_periodicidade,
    nr_periodo            = nr_periodo,
    co_tipo_demonstrativo = co_tipo_demonstrativo,
    no_anexo              = no_anexo,
    co_esfera             = co_esfera,
    co_poder              = co_poder,
    id_ente               = id_ente
  )

  siconfi_fetch_all("/rgf", params, use_cache = use_cache)
}
