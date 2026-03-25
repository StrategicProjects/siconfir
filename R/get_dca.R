#' Get annual accounts data (DCA)
#'
#' Retrieves data from the Annual Accounts Declaration (DCA) or the legacy
#' QDCC for a specific entity and fiscal year.
#'
#' `get_annual_accounts()` is an English alias for `get_dca()`.
#'
#' @param an_exercicio Integer. Fiscal year (e.g., `2022`). **Required**.
#' @param id_ente Integer. IBGE code of the entity. **Required**.
#' @param no_anexo Character. Appendix name filter (e.g., `"DCA-Anexo I-AB"`).
#'   Optional.
#' @param use_cache Logical. If `TRUE` (default), uses an in-memory cache.
#'
#' @return A [tibble][tibble::tibble] with DCA/QDCC data including columns such
#'   as `exercicio`, `instituicao`, `cod_ibge`, `uf`, `anexo`, `rotulo`,
#'   `coluna`, `cod_conta`, `conta`, `valor`, and `populacao`.
#'
#' @export
#' @examples
#' \dontrun{
#' # DCA data for the state of Tocantins in 2022
#' dca <- get_dca(an_exercicio = 2022, id_ente = 17)
#' }
get_dca <- function(an_exercicio, id_ente, no_anexo = NULL, use_cache = TRUE) {
  check_required(an_exercicio, id_ente)

  params <- list(
    an_exercicio = an_exercicio,
    id_ente      = id_ente,
    no_anexo     = no_anexo
  )

  siconfi_fetch_all("/dca", params, use_cache = use_cache)
}
