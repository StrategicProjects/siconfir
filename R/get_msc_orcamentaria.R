#' Get MSC budgetary accounts data
#'
#' Retrieves budgetary accounts data (classes 5 and 6) from the
#' Accounting Balances Matrix (MSC) for a specific entity,
#' year, month, and matrix type.
#'
#' `get_msc_budget()` is an English alias for `get_msc_orcamentaria()`.
#'
#' @param id_ente Integer. IBGE code of the entity. **Required**.
#' @param an_referencia Integer. Reference year. **Required**.
#' @param me_referencia Integer. Reference month (1-12). **Required**.
#' @param co_tipo_matriz Character. Matrix type: `"MSCC"` (monthly aggregate)
#'   or `"MSCE"` (annual closing). **Required**.
#' @param classe_conta Integer. Account class: `5` or `6`. **Required**.
#' @param id_tv Character. Value type: `"beginning_balance"`,
#'   `"ending_balance"`, or `"period_change"`. **Required**.
#' @param use_cache Logical. If `TRUE` (default), uses an in-memory cache.
#'
#' @return A [tibble][tibble::tibble] with MSC budgetary account data.
#'
#' @export
#' @examples
#' \dontrun{
#' msc_orc <- get_msc_orcamentaria(
#'   id_ente = 17, an_referencia = 2022, me_referencia = 12,
#'   co_tipo_matriz = "MSCC", classe_conta = 6,
#'   id_tv = "period_change"
#' )
#' }
get_msc_orcamentaria <- function(id_ente, an_referencia, me_referencia,
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

  siconfi_fetch_all("/msc_orcamentaria", params, use_cache = use_cache)
}
