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

#' Maximum number of retries for transient connection errors
#' @noRd
max_retries <- 3L

#' Pause between retries (seconds)
#' @noRd
retry_wait <- 2L

#' Build and perform a single request to the SICONFI API
#'
#' Wraps `httr2::req_perform()` with user-friendly error handling for
#' connection failures, HTTP errors, and JSON parsing issues. Retries
#' transient connection errors up to `max_retries` times.
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
    httr2::req_error(is_error = function(resp) FALSE)

  # Retry loop with friendly error messages
  resp <- NULL
  last_error <- NULL

  for (attempt in seq_len(max_retries)) {
    last_error <- NULL

    resp <- tryCatch(
      httr2::req_perform(req),
      error = function(e) {
        last_error <<- e
        NULL
      }
    )

    if (!is.null(resp)) break

    if (attempt < max_retries) {
      wait <- retry_wait * attempt
      cli::cli_alert_warning(
        paste0(
          "Connection failed (attempt {attempt}/{max_retries}). ",
          "Retrying in {wait}s..."
        )
      )
      Sys.sleep(wait)
    }
  }

  # All retries exhausted

  if (is.null(resp)) {
    err_msg <- conditionMessage(last_error)

    # Classify the error for a friendlier message
    hint <- if (grepl("HTTP/2|stream|PROTOCOL_ERROR", err_msg)) {
      "The server closed the connection unexpectedly (HTTP/2 protocol error)."
    } else if (grepl("resolve|DNS|getaddrinfo", err_msg, ignore.case = TRUE)) {
      "Could not resolve the API hostname. Check your internet connection."
    } else if (grepl("timed? ?out|timeout", err_msg, ignore.case = TRUE)) {
      "The request timed out. The API may be temporarily unavailable."
    } else if (grepl("connection refused|connrefused", err_msg,
                      ignore.case = TRUE)) {
      "Connection refused by the server."
    } else if (grepl("SSL|certificate|TLS", err_msg, ignore.case = TRUE)) {
      "SSL/TLS error. There may be a network or certificate issue."
    } else {
      NULL
    }

    bullets <- c(
      "x" = "Failed to connect to the SICONFI API after {max_retries} attempts.",
      "i" = "Endpoint: {.field {endpoint}}",
      if (!is.null(hint)) c("!" = hint),
      "i" = "Original error: {err_msg}",
      "i" = "Try again later or check your internet connection."
    )

    cli::cli_abort(bullets, call = NULL)
  }

  # Check HTTP status
  status <- httr2::resp_status(resp)
  if (status != 200L) {
    cli::cli_abort(c(
      "x" = "SICONFI API returned HTTP status {.val {status}}.",
      "i" = "Endpoint: {.field {endpoint}}",
      "i" = if (status == 404L) {
        "The endpoint or entity was not found. Check your parameters."
      } else if (status >= 500L) {
        "Server error. The API may be temporarily unavailable."
      } else if (status == 429L) {
        "Rate limited. Wait a moment before retrying."
      } else {
        "Check your parameters and try again."
      }
    ), call = NULL)
  }

  # Parse JSON
  body <- tryCatch(
    httr2::resp_body_json(resp, simplifyVector = TRUE),
    error = function(e) {
      cli::cli_abort(c(
        "x" = "Failed to parse the API response as JSON.",
        "i" = "Endpoint: {.field {endpoint}}",
        "i" = "The API may have returned an unexpected format.",
        "i" = "Original error: {conditionMessage(e)}"
      ), call = NULL)
    }
  )

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
