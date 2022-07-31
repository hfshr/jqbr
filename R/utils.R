#' Drop nulls
#' @param x list potentially containg nulls
#' @noRd
drop_nulls <- function(x) {
  x[!vapply(x, is.null, FUN.VALUE = logical(1))]
}

#' Filter validation
#'
#' @param filters List of filters to check
#'
#'
#' @noRd
validate_filters <- function(filters) {
  if (!is.list(filters)) {
    stop(
      "Filters must be supplied in a list",
      call. = FALSE
    )
  }

  if (FALSE %in% unlist(lapply(filters, is.list))) {
    stop(
      "All filters must be a list",
      call. = FALSE
    )
  }
}

#' Plugin validation
#'
#' @param plugins List of plugins to check.
#'
#' @noRd
validate_plugins <- function(plugins) {
  accepted_plugins <- c(
    "sortable",
    "filter-description",
    "unique-filter",
    "bt-tooltip-errors",
    "bt-selectpicker",
    "bt-checkbox",
    "invert",
    "not-group",
    "chosen-selectpicker",
    "bootbox"
  )
  if (any(!names(plugins) %in% accepted_plugins)) {
    stop(
      sprintf("Plugins must be one of %s", accepted_plugins),
      call. = FALSE
    )
  }
}