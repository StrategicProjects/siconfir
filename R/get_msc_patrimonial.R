#' Get MSC equity/asset accounts data
#'
#' Retrieves equity and asset accounts data (classes 1 to 4) from the
#' Accounting Balances Matrix (MSC) for a specific
#' entity, year, month, and matrix type.
#'
#' `get_msc_equity()` is an English alias for `get_msc_patrimonial()`.
#'
#' @param id_ente Integer. IBGE code of the entity. **Required**.
#' @param an_referencia Integer. Reference year. **Required**.
#' @param me_referencia Integer. Reference month (1-12). **Required**.
#' @param co_tipo_matriz Character. Matrix type: `"MSCC"` (monthly aggregate)
#'   or `"MSCE"` (annual closing). **Required**.
#' @param classe_conta Integer. Account class: `1`, `2`, `3`, or `4`.
#'   **Required**.
#' @param id_tv Character. Value type: `"beginning_balance"`,
#'   `"ending_balance"`, or `"period_change"`. **Required**.
#' @param use_cache Logical. If `TRUE` (default), uses an in-memory cache.
#'
#' @return A [tibble][tibble::tibble] with MSC equity/asset account data.
#'
#' @export
#' @examples
#' \dontrun{
#' msc_pat <- get_msc_patrimonial(
#'   id_ente = 17, an_referencia = 2022, me_referencia = 12,
#'   co_tipo_matriz = "MSCC", classe_conta = 1,
#'   id_tv = "ending_balance"
#' )
#' }
get_msc_patrimonial <- function(id_ente, an_referencia, me_referencia,
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

  siconfi_fetch_all("/msc_patrimonial", params, use_cache = use_cache)
}
