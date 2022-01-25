
dropNulls <- function(x) {
  x[!vapply(x, is.null, FUN.VALUE = logical(1))]
}

validate_filters <- function(filters) {
  if (!is.list(filters)) {
    rlang::abort(
      "Filters must be supplied in a list"
    )
  }

  if (FALSE %in% unlist(lapply(filters, is.list))) {
    rlang::abort(
      "All filters must be a list"
    )
  }
}

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
