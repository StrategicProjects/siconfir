#' Get list of Brazilian government entities
#'
#' Retrieves the complete list of government entities (entes) registered in the
#' SICONFI system, including states, municipalities, and the Federal District.
#'
#' `get_entities()` is an English alias for `get_entes()`.
#'
#' @param use_cache Logical. If `TRUE` (default), uses an in-memory cache.
#'
#' @return A [tibble][tibble::tibble] with columns:
#'   \describe{
#'     \item{cod_ibge}{IBGE code of the entity.}
#'     \item{ente}{Name of the entity.}
#'     \item{capital}{Whether the municipality is a state capital (1 = yes, 0 = no).}
#'     \item{regiao}{Geographic region (`"SU"`, `"NE"`, `"NO"`, `"SE"`, `"CO"`, `"BR"`).}
#'     \item{uf}{State abbreviation.}
#'     \item{esfera}{Government sphere: `"M"`, `"E"`, `"U"`, `"D"`.}
#'     \item{an_exercicio}{Year of the population data.}
#'     \item{populacao}{Estimated population.}
#'     \item{co_cnpj}{CNPJ of the entity.}
#'   }
#'
#' @export
#' @examples
#' \dontrun{
#' entes <- get_entes()
#' }
get_entes <- function(use_cache = TRUE) {
  siconfi_fetch_all("/entes", use_cache = use_cache)
}
