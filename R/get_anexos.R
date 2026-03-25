#' Get report appendix reference table
#'
#' Retrieves the reference table of report appendices (anexos) grouped by
#' government sphere. This is a support table that describes which appendices
#' are available for each report type (RREO, RGF, DCA, etc.).
#'
#' `get_annexes()` is an English alias for `get_anexos()`.
#'
#' @param use_cache Logical. If `TRUE` (default), uses an in-memory cache to
#'   avoid repeated requests within the same session.
#'
#' @return A [tibble][tibble::tibble] with columns:
#'   \describe{
#'     \item{esfera}{Government sphere: `"U"` (Union), `"E"` (States), `"M"` (Municipalities).}
#'     \item{demonstrativo}{Report type (e.g., `"RREO"`, `"RGF"`, `"DCA"`).}
#'     \item{anexo}{Appendix name (e.g., `"RREO-Anexo 01"`).}
#'   }
#'
#' @export
#' @examples
#' \dontrun{
#' anexos <- get_anexos()
#' }
get_anexos <- function(use_cache = TRUE) {
  siconfi_fetch_all("/anexos-relatorios", use_cache = use_cache)
}
