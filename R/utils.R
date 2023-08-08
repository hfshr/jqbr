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

#' Operator list
#'
#' Helper function to specify the all available operators.
#'
#' @param operator_type string. one of "sql_operators" or "r_operators".
#'
#'
#' @noRd
operator_list <- function(add_na_filter = FALSE) {
  ops <- list(
    list(type = "equal"),
    list(type = "not_equal"),
    list(type = "in"),
    list(type = "not_in"),
    list(type = "less"),
    list(type = "less_or_equal"),
    list(type = "greater"),
    list(type = "greater_or_equal"),
    list(type = "between"),
    list(type = "not_between"),
    list(type = "begins_with"),
    list(type = "not_begins_with"),
    list(type = "contains"),
    list(type = "not_contains"),
    list(type = "ends_with"),
    list(type = "not_ends_with"),
    list(type = "is_null"),
    list(type = "is_not_null"),
    list(type = "is_not_empty"),
    list(type = "is_empty")
  )


  if (add_na_filter) {
    ops <- append(
      ops,
      list(
        list(type = "is_na", nb_inputs = 0, apply_to = c("string", "number", "datetime", "boolean")),
        list(type = "is_not_na", nb_inputs = 0, apply_to = c("string", "number", "datetime", "boolean"))
      )
    )
  }
  ops
}