# Internal utilities for siconfir
# These functions are not exported

# -- Parameter validation ------------------------------------------------------

#' Check that required arguments were supplied via missing()
#'
#' Evaluates `missing()` for each argument name in the caller's frame.
#' Works correctly both for direct calls and for alias wrappers.
#'
#' @param ... Unquoted argument names to check (bare symbols).
#'
#' @noRd
check_required <- function(...) {
  args <- as.character(match.call())[-1]
  env <- parent.frame()
  missing_args <- character()

  for (arg in args) {
    tryCatch(
      {
        val <- eval(call("missing", as.symbol(arg)), envir = env)
        if (isTRUE(val)) missing_args <- c(missing_args, arg)
      },
      error = function(e) {
        missing_args <<- c(missing_args, arg)
      }
    )
  }

  if (length(missing_args) > 0) {
    cli::cli_abort(
      "Missing required argument{?s}: {.arg {missing_args}}."
    )
  }
  invisible(NULL)
}

# -- Base URL ------------------------------------------------------------------

base_url <- function() {

"https://apidatalake.tesouro.gov.br/ords/siconfi/tt"
}

# -- In-memory cache -----------------------------------------------------------

# Environment used as a simple in-memory cache for the session
the_cache <- new.env(parent = emptyenv())

cache_key <- function(url, params) {
  parts <- c(url, sort(paste0(names(params), "=", params)))
  digest <- paste(parts, collapse = "|")
  digest
}

cache_get <- function(key) {
  if (exists(key, envir = the_cache)) {
    return(get(key, envir = the_cache))
  }
  NULL
}

cache_set <- function(key, value) {
  assign(key, value, envir = the_cache)
  invisible(value)
}

#' Clear the siconfir in-memory cache
#'
#' Removes all cached API responses stored during the current R session.
#'
#' @return Invisible `NULL`.
#' @export
#' @examples
#' siconfir_clear_cache()
siconfir_clear_cache <- function() {
  rm(list = ls(envir = the_cache), envir = the_cache)
  cli::cli_alert_info("Cache cleared.")
  invisible(NULL)
}

# -- Request builder -----------------------------------------------------------

#' Build and perform a single request to the SICONFI API
#'
#' @param endpoint Character. Path appended to the base URL (e.g., "/entes").
#' @param params Named list of query parameters (NULLs are dropped).
#' @param use_cache Logical. Whether to use in-memory cache.
#'
#' @return Parsed JSON body as a list.
#' @noRd
siconfi_request <- function(endpoint, params = list(), use_cache = TRUE) {
  # Drop NULL params

  params <- Filter(Negate(is.null), params)

  url <- paste0(base_url(), endpoint)

  # Check cache
  if (use_cache) {
    key <- cache_key(url, params)
    cached <- cache_get(key)
    if (!is.null(cached)) {
      cli::cli_alert_info("Using cached response for {.url {endpoint}}.")
      return(cached)
    }
  }

  req <- httr2::request(url) |>
    httr2::req_url_query(!!!params) |>
    httr2::req_headers(Accept = "application/json") |>
    httr2::req_retry(max_tries = 3, backoff = ~ 2) |>
    httr2::req_error(is_error = function(resp) FALSE)

  resp <- httr2::req_perform(req)

  status <- httr2::resp_status(resp)
  if (status != 200L) {
    cli::cli_abort(c(
      "SICONFI API returned status {status}.",
      "i" = "Endpoint: {.url {endpoint}}",
      "i" = "Check your parameters."
    ))
  }

  body <- httr2::resp_body_json(resp, simplifyVector = TRUE)

  if (use_cache) {
    cache_set(key, body)
  }

  body
}

# -- Pagination ----------------------------------------------------------------

#' Fetch all pages from a paginated SICONFI API endpoint
#'
#' The SICONFI API uses ORDS-style pagination with `hasMore`, `offset`, and
#' `limit` fields plus a `next` link in the response. This function follows
#' all pages and row-binds the results.
#'
#' @param endpoint Character. API endpoint path.
#' @param params Named list of query parameters.
#' @param use_cache Logical. Whether to cache individual page responses.
#'
#' @return A tibble with all rows from every page.
#' @noRd
siconfi_fetch_all <- function(endpoint, params = list(), use_cache = TRUE) {
  all_items <- list()
  page <- 1L

  cli::cli_alert_info("Fetching data from {.field {endpoint}}...")

  body <- siconfi_request(endpoint, params, use_cache = use_cache)
  items <- body[["items"]]

  if (is.null(items) || length(items) == 0) {
    cli::cli_alert_warning("No data returned for {.field {endpoint}}.")
    return(tibble::tibble())
  }

  all_items[[page]] <- items
  has_more <- isTRUE(body[["hasMore"]])

  while (has_more) {
    page <- page + 1L

    # The API returns `offset` in the response; we use it for the next page
    offset <- body[["offset"]]
    limit  <- body[["limit"]]

    if (is.null(offset) || is.null(limit)) break

    next_offset <- offset + limit
    next_params <- c(params, list(offset = next_offset))

    body  <- siconfi_request(endpoint, next_params, use_cache = use_cache)
    items <- body[["items"]]

    if (is.null(items) || length(items) == 0) break

    all_items[[page]] <- items
    has_more <- isTRUE(body[["hasMore"]])
  }

  result <- dplyr::bind_rows(lapply(all_items, tibble::as_tibble))

  # Trim extra whitespace from character columns (API quirk)
  result <- dplyr::mutate(
    result,
    dplyr::across(dplyr::where(is.character), stringr::str_squish)
  )

  cli::cli_alert_success(
    "Retrieved {.val {nrow(result)}} rows ({.val {page}} page{?s})."
  )

  result
}
