#' Get Budget Execution Summary Report data (RREO)
#'
#' Retrieves data from the Budget Execution Summary Report (RREO) for specific
#' filtering criteria. The RREO is published bimonthly and contains
#' information about revenues, expenses, and other budgetary data.
#'
#' `get_budget_report()` is an English-parameter alias for this function.
#'
#' @param an_exercicio Integer. Fiscal year (e.g., `2022`). **Required**.
#' @param nr_periodo Integer. Bimester number (1-6). **Required**.
#' @param co_tipo_demonstrativo Character. Report type: `"RREO"` or
#'   `"RREO Simplificado"`. **Required**.
#' @param no_anexo Character. Appendix name (e.g., `"RREO-Anexo 01"`).
#'   **Required**.
#' @param co_esfera Character. Government sphere: `"M"` (municipalities),
#'   `"E"` (states), or `"U"` (union). **Required**.
#' @param id_ente Integer. IBGE code of the entity. **Required**.
#' @param use_cache Logical. If `TRUE` (default), uses an in-memory cache.
#'
#' @return A [tibble][tibble::tibble] with RREO data including columns such as
#'   `exercicio`, `demonstrativo`, `periodo`, `periodicidade`, `instituicao`,
#'   `cod_ibge`, `uf`, `populacao`, `anexo`, `rotulo`, `coluna`, `cod_conta`,
#'   `conta`, and `valor`.
#'
#' @export
#' @examples
#' \dontrun{
#' rreo <- get_rreo(
#'   an_exercicio = 2022, nr_periodo = 6,
#'   co_tipo_demonstrativo = "RREO",
#'   no_anexo = "RREO-Anexo 01",
#'   co_esfera = "E", id_ente = 17
#' )
#' }
get_rreo <- function(an_exercicio, nr_periodo, co_tipo_demonstrativo,
                     no_anexo, co_esfera, id_ente, use_cache = TRUE) {
  check_required(
    an_exercicio, nr_periodo, co_tipo_demonstrativo,
    no_anexo, co_esfera, id_ente
  )

  params <- list(
    an_exercicio          = an_exercicio,
    nr_periodo            = nr_periodo,
    co_tipo_demonstrativo = co_tipo_demonstrativo,
    no_anexo              = no_anexo,
    co_esfera             = co_esfera,
    id_ente               = id_ente
  )

  siconfi_fetch_all("/rreo", params, use_cache = use_cache)
}
