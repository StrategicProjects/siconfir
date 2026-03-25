#' Get MSC control accounts data
#'
#' Retrieves control accounts data (classes 7 and 8) from the
#' Accounting Balances Matrix (MSC) for a specific entity,
#' year, month, and matrix type.
#'
#' `get_msc_control()` is an English alias for `get_msc_controle()`.
#'
#' @param id_ente Integer. IBGE code of the entity. **Required**.
#' @param an_referencia Integer. Reference year. **Required**.
#' @param me_referencia Integer. Reference month (1-12). **Required**.
#' @param co_tipo_matriz Character. Matrix type: `"MSCC"` (monthly aggregate)
#'   or `"MSCE"` (annual closing). **Required**.
#' @param classe_conta Integer. Account class: `7` or `8`. **Required**.
#' @param id_tv Character. Value type: `"beginning_balance"`,
#'   `"ending_balance"`, or `"period_change"`. **Required**.
#' @param use_cache Logical. If `TRUE` (default), uses an in-memory cache.
#'
#' @return A [tibble][tibble::tibble] with MSC control account data.
#'
#' @export
#' @examples
#' \dontrun{
#' msc_ctrl <- get_msc_controle(
#'   id_ente = 17, an_referencia = 2022, me_referencia = 12,
#'   co_tipo_matriz = "MSCC", classe_conta = 8,
#'   id_tv = "ending_balance"
#' )
#' }
get_msc_controle <- function(id_ente, an_referencia, me_referencia,
                             co_tipo_matriz, classe_conta, id_tv,
                             use_cache = TRUE) {
  check_required(
    id_ente, an_referencia, me_referencia,
    co_tipo_matriz, classe_conta, id_tv
  )

  params <- list(
    id_ente        = id_ente,
    an_referencia  = an_referencia,
    me_referencia  = me_referencia,
    co_tipo_matriz = co_tipo_matriz,
    classe_conta   = classe_conta,
    id_tv          = id_tv
  )

  siconfi_fetch_all("/msc_controle", params, use_cache = use_cache)
}
