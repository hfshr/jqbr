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

validate_operators <- function(operators, return_value) {
  all_operators <- unlist(lapply(operators, `[[`, "type"))
  if (return_value %in% c("all", "sql") &&
    any(grepl("\\bis_na\\b|\\bis_not_na\\b", all_operators))) {
    stop(
      "Operators must not include `is_na` or `is_not_na`
      when using return_type \"all\" or \"sql_rules\"",
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
operator_list <- function(operator_type = c("sql_operators", "r_operators")) {
  operator_type <- match.arg(operator_type)
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
    list(type = "is_not_null")
  )


  if (operator_type == "sql_operators") {
    ops <- append(
      ops,
      list(
        list(type = "is_not_empty"),
        list(type = "is_empty")
      )
    )
  }

  if (operator_type == "r_operators") {
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