# English aliases for all API functions
#
# These provide fully English alternatives (function names AND parameter
# names) so users can work entirely in English. The original Portuguese-named
# functions remain available and map directly to the API parameter names.
#
# Parameter mapping (Portuguese -> English):
#   an_exercicio          -> fiscal_year
#   id_ente               -> entity_id
#   no_anexo              -> appendix
#   an_referencia         -> year
#   me_referencia         -> month
#   nr_periodo            -> period
#   co_tipo_demonstrativo -> report_type
#   co_esfera             -> sphere
#   co_poder              -> branch
#   in_periodicidade      -> periodicity
#   co_tipo_matriz        -> matrix_type
#   classe_conta          -> account_class
#   id_tv                 -> value_type

# -- get_entities --------------------------------------------------------------

#' @rdname get_entes
#' @usage get_entities(use_cache = TRUE)
#' @export
get_entities <- function(use_cache = TRUE) {
  get_entes(use_cache = use_cache)
}

# -- get_annexes ---------------------------------------------------------------

#' @rdname get_anexos
#' @usage get_annexes(use_cache = TRUE)
#' @export
get_annexes <- function(use_cache = TRUE) {
  get_anexos(use_cache = use_cache)
}

# -- get_annual_accounts -------------------------------------------------------

#' Get annual accounts data (DCA) -- English interface
#'
#' English-parameter alias for [get_dca()]. See that function for full
#' details on return values and API behavior.
#'
#' @param fiscal_year Integer. Fiscal year (e.g., `2022`). Maps to
#'   `an_exercicio`.
#' @param entity_id Integer. IBGE code of the entity. Maps to `id_ente`.
#' @param appendix Character. Appendix name filter (e.g.,
#'   `"DCA-Anexo I-AB"`). Optional. Maps to `no_anexo`.
#' @param use_cache Logical. If `TRUE` (default), uses an in-memory cache.
#'
#' @return A [tibble][tibble::tibble] with DCA data.
#' @seealso [get_dca()] for the original Portuguese-parameter interface.
#' @export
#' @examples
#' \dontrun{
#' dca <- get_annual_accounts(fiscal_year = 2022, entity_id = 17)
#' }
get_annual_accounts <- function(fiscal_year, entity_id, appendix = NULL,
                                use_cache = TRUE) {
  check_required(fiscal_year, entity_id)
  get_dca(
    an_exercicio = fiscal_year,
    id_ente      = entity_id,
    no_anexo     = appendix,
    use_cache    = use_cache
  )
}

# -- get_delivery_status -------------------------------------------------------

#' Get delivery status extract -- English interface
#'
#' English-parameter alias for [get_extrato()]. See that function for full
#' details on return values and API behavior.
#'
#' @param entity_id Integer. IBGE code of the entity. Maps to `id_ente`.
#' @param year Integer. Reference year (e.g., `2022`). Maps to
#'   `an_referencia`.
#' @param use_cache Logical. If `TRUE` (default), uses an in-memory cache.
#'
#' @return A [tibble][tibble::tibble] with delivery status data.
#' @seealso [get_extrato()] for the original Portuguese-parameter interface.
#' @export
#' @examples
#' \dontrun{
#' status <- get_delivery_status(entity_id = 17, year = 2022)
#' }
get_delivery_status <- function(entity_id, year, use_cache = TRUE) {
  check_required(entity_id, year)
  get_extrato(
    id_ente       = entity_id,
    an_referencia = year,
    use_cache     = use_cache
  )
}

# -- get_budget_report ---------------------------------------------------------

#' Get Budget Execution Summary Report (RREO) -- English interface
#'
#' English-parameter alias for [get_rreo()]. See that function for full
#' details on return values and API behavior.
#'
#' @param fiscal_year Integer. Fiscal year (e.g., `2022`). Maps to
#'   `an_exercicio`.
#' @param period Integer. Bimester number (1--6). Maps to `nr_periodo`.
#' @param report_type Character. `"RREO"` or `"RREO Simplificado"`. Maps
#'   to `co_tipo_demonstrativo`. Note: `"RREO Simplificado"` applies only to municipalities with fewer than 50,000 inhabitants that opted for simplified reporting.
#' @param appendix Character. Appendix name (e.g., `"RREO-Anexo 01"`).
#'   Maps to `no_anexo`.
#' @param sphere Character. Government sphere: `"M"` (municipalities),
#'   `"E"` (states), or `"U"` (union). Maps to `co_esfera`.
#' @param entity_id Integer. IBGE code of the entity. Maps to `id_ente`.
#' @param use_cache Logical. If `TRUE` (default), uses an in-memory cache.
#'
#' @return A [tibble][tibble::tibble] with RREO data.
#' @seealso [get_rreo()] for the original Portuguese-parameter interface.
#' @export
#' @examples
#' \dontrun{
#' rreo <- get_budget_report(
#'   fiscal_year = 2022, period = 6,
#'   report_type = "RREO",
#'   appendix = "RREO-Anexo 01",
#'   sphere = "E", entity_id = 17
#' )
#' }
get_budget_report <- function(fiscal_year, period, report_type,
                              appendix, sphere, entity_id,
                              use_cache = TRUE) {
  check_required(fiscal_year, period, report_type, appendix, sphere, entity_id)
  get_rreo(
    an_exercicio          = fiscal_year,
    nr_periodo            = period,
    co_tipo_demonstrativo = report_type,
    no_anexo              = appendix,
    co_esfera             = sphere,
    id_ente               = entity_id,
    use_cache             = use_cache
  )
}

# -- get_fiscal_report ---------------------------------------------------------

#' Get Fiscal Management Report (RGF) -- English interface
#'
#' English-parameter alias for [get_rgf()]. See that function for full
#' details on return values and API behavior.
#'
#' @param fiscal_year Integer. Fiscal year (e.g., `2022`). Maps to
#'   `an_exercicio`.
#' @param periodicity Character. `"Q"` (four-monthly) or `"S"`
#'   (semi-annual). Maps to `in_periodicidade`.
#' @param period Integer. Period number (1--3 for four-monthly, 1--2 for
#'   semi-annual). Maps to `nr_periodo`.
#' @param report_type Character. `"RGF"` or `"RGF Simplificado"`. Maps
#'   to `co_tipo_demonstrativo`.
#' @param appendix Character. Appendix name (e.g., `"RGF-Anexo 01"`).
#'   Maps to `no_anexo`.
#' @param sphere Character. Government sphere: `"M"`, `"E"`, or `"U"`.
#'   Maps to `co_esfera`.
#' @param branch Character. Government branch: `"E"` (executive),
#'   `"L"` (legislative), `"J"` (judiciary), `"M"` (public ministry),
#'   `"D"` (public defender). Maps to `co_poder`.
#' @param entity_id Integer. IBGE code of the entity. Maps to `id_ente`.
#' @param use_cache Logical. If `TRUE` (default), uses an in-memory cache.
#'
#' @return A [tibble][tibble::tibble] with RGF data.
#' @seealso [get_rgf()] for the original Portuguese-parameter interface.
#' @export
#' @examples
#' \dontrun{
#' rgf <- get_fiscal_report(
#'   fiscal_year = 2022, periodicity = "Q", period = 3,
#'   report_type = "RGF", appendix = "RGF-Anexo 01",
#'   sphere = "E", branch = "E", entity_id = 17
#' )
#' }
get_fiscal_report <- function(fiscal_year, periodicity, period,
                              report_type, appendix, sphere,
                              branch, entity_id, use_cache = TRUE) {
  check_required(
    fiscal_year, periodicity, period, report_type,
    appendix, sphere, branch, entity_id
  )
  get_rgf(
    an_exercicio          = fiscal_year,
    in_periodicidade      = periodicity,
    nr_periodo            = period,
    co_tipo_demonstrativo = report_type,
    no_anexo              = appendix,
    co_esfera             = sphere,
    co_poder              = branch,
    id_ente               = entity_id,
    use_cache             = use_cache
  )
}

# -- get_msc_control -----------------------------------------------------------

#' Get MSC control accounts -- English interface
#'
#' English-parameter alias for [get_msc_controle()]. See that function for
#' full details on return values and API behavior.
#'
#' @param entity_id Integer. IBGE code of the entity. Maps to `id_ente`.
#' @param year Integer. Reference year. Maps to `an_referencia`.
#' @param month Integer. Reference month (1--12). Maps to `me_referencia`.
#' @param matrix_type Character. `"MSCC"` (monthly) or `"MSCE"` (annual
#'   closing). Maps to `co_tipo_matriz`.
#' @param account_class Integer. Account class: `7` or `8`. Maps to
#'   `classe_conta`.
#' @param value_type Character. `"beginning_balance"`,
#'   `"ending_balance"`, or `"period_change"`. Maps to `id_tv`.
#' @param use_cache Logical. If `TRUE` (default), uses an in-memory cache.
#'
#' @return A [tibble][tibble::tibble] with MSC control account data.
#' @seealso [get_msc_controle()] for the original Portuguese-parameter
#'   interface.
#' @export
#' @examples
#' \dontrun{
#' msc <- get_msc_control(
#'   entity_id = 17, year = 2022, month = 12,
#'   matrix_type = "MSCC", account_class = 8,
#'   value_type = "ending_balance"
#' )
#' }
get_msc_control <- function(entity_id, year, month,
                            matrix_type, account_class, value_type,
                            use_cache = TRUE) {
  check_required(entity_id, year, month, matrix_type, account_class, value_type)
  get_msc_controle(
    id_ente        = entity_id,
    an_referencia  = year,
    me_referencia  = month,
    co_tipo_matriz = matrix_type,
    classe_conta   = account_class,
    id_tv          = value_type,
    use_cache      = use_cache
  )
}

# -- get_msc_budget ------------------------------------------------------------

#' Get MSC budgetary accounts -- English interface
#'
#' English-parameter alias for [get_msc_orcamentaria()]. See that function
#' for full details on return values and API behavior.
#'
#' @inheritParams get_msc_control
#' @param account_class Integer. Account class: `5` or `6`. Maps to
#'   `classe_conta`.
#'
#' @return A [tibble][tibble::tibble] with MSC budgetary account data.
#' @seealso [get_msc_orcamentaria()] for the original Portuguese-parameter
#'   interface.
#' @export
#' @examples
#' \dontrun{
#' msc <- get_msc_budget(
#'   entity_id = 17, year = 2022, month = 12,
#'   matrix_type = "MSCC", account_class = 6,
#'   value_type = "period_change"
#' )
#' }
get_msc_budget <- function(entity_id, year, month,
                           matrix_type, account_class, value_type,
                           use_cache = TRUE) {
  check_required(entity_id, year, month, matrix_type, account_class, value_type)
  get_msc_orcamentaria(
    id_ente        = entity_id,
    an_referencia  = year,
    me_referencia  = month,
    co_tipo_matriz = matrix_type,
    classe_conta   = account_class,
    id_tv          = value_type,
    use_cache      = use_cache
  )
}

# -- get_msc_equity ------------------------------------------------------------

#' Get MSC equity/asset accounts -- English interface
#'
#' English-parameter alias for [get_msc_patrimonial()]. See that function
#' for full details on return values and API behavior.
#'
#' @inheritParams get_msc_control
#' @param account_class Integer. Account class: `1`, `2`, `3`, or `4`.
#'   Maps to `classe_conta`.
#'
#' @return A [tibble][tibble::tibble] with MSC equity/asset account data.
#' @seealso [get_msc_patrimonial()] for the original Portuguese-parameter
#'   interface.
#' @export
#' @examples
#' \dontrun{
#' msc <- get_msc_equity(
#'   entity_id = 17, year = 2022, month = 12,
#'   matrix_type = "MSCC", account_class = 1,
#'   value_type = "ending_balance"
#' )
#' }
get_msc_equity <- function(entity_id, year, month,
                           matrix_type, account_class, value_type,
                           use_cache = TRUE) {
  check_required(entity_id, year, month, matrix_type, account_class, value_type)
  get_msc_patrimonial(
    id_ente        = entity_id,
    an_referencia  = year,
    me_referencia  = month,
    co_tipo_matriz = matrix_type,
    classe_conta   = account_class,
    id_tv          = value_type,
    use_cache      = use_cache
  )
}
