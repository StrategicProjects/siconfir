#' Get delivery status extract
#'
#' Retrieves the extract of report deliveries for a given entity and reference
#' year. Useful for checking which reports have been submitted and their status
#' (approved, rectified, etc.).
#'
#' `get_delivery_status()` is an English alias for `get_extrato()`.
#'
#' @param id_ente Integer. IBGE code of the entity. **Required**.
#' @param an_referencia Integer. Reference year (e.g., `2022`). **Required**.
#' @param use_cache Logical. If `TRUE` (default), uses an in-memory cache.
#'
#' @return A [tibble][tibble::tibble] with delivery status data including
#'   columns such as `exercicio`, `cod_ibge`, `instituicao`, `entregavel`,
#'   `periodo`, `periodicidade`, `status_relatorio`, `data_status`,
#'   `forma_envio`, and `tipo_relatorio`.
#'
#' @export
#' @examples
#' \dontrun{
#' extrato <- get_extrato(id_ente = 17, an_referencia = 2022)
#' }
get_extrato <- function(id_ente, an_referencia, use_cache = TRUE) {
  check_required(id_ente, an_referencia)

  params <- list(
    id_ente       = id_ente,
    an_referencia = an_referencia
  )

  siconfi_fetch_all("/extrato_entregas", params, use_cache = use_cache)
}
