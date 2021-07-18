#' filterTable
#'
#' filter a data frame using the output of a queryBuilder htmlWidget
#'
#' @param filters output from queryBuilder htmlWidget sent from shiny app as \code{input$el_out}
#' where \code{el} is the htmlWidget element
#' @param data data frame to filter
#' @param date_format optional string specifying the date format used with the datepicker
#' plugin. See `?as.Date()`.
#' @param output string return either a filtered data frame (table) or a text representation
#' of the filter (text)
#'
#' @importFrom dplyr filter `%>%`
#' @importFrom rlang parse_expr
#'
#' @export
filterTable <- function(filters = NULL,
                        data = NULL,
                        date_format = NULL,
                        output = c("table", "text")) {
  output <- match.arg(output)
  if (is.null(filters) || !length(filters) || is.null(data)) {
    return(data)
  }
  ## Run through list recursively and generate a filter
  f <- recurseFilter(filter = filters,
                     date_format = date_format)
  if (output == "text") {
    return(f)
  } else if (output == "table") {
    df <- data %>%
      dplyr::filter(!!rlang::parse_expr(f))
    return(df)
  } else {
    return()
  }
}


#' lookup
#'
#' internal function to create a filter condition based on id, operator and value
#'
#' @param id data frame column id
#' @param operator filter operator as defined within queryBuilder
#' @param value filter value
#' @return string representation of a single filter
#'
lookup <- function(id, operator, value) {
  id <- paste0("`", id, "`")
  ## triple style operator, eg a = 1
  l.operators1 <- list(
    "equal" = "==", "not_equal" = "!=", "less" = "<", "less_or_equal" = "<=", "greater" = ">", "greater_or_equal" = ">=",
    "equal_" = "==", "not_equal_" = "!=", "less_" = "<", "less_or_equal_" = "<=", "greater_" = ">", "greater_or_equal_" = ">="
  )
  ## functional style operator, eg startswith(a, value)
  l.operators2 <- list("begins_with" = "startsWith", "not_begins_with" = "!startsWith", "ends_with" = "endsWith", "not_ends_with" = "!endsWith")
  ## grep style operator, eg grepl(value, a)
  l.operators3 <- list("contains" = "grepl", "not_contains" = "!grepl")
  ## two-value style operator, eg a > 10 & a < 20
  l.operators4 <- list("between" = "between", "not_between" = "not_between")
  ## simple boolean function, eg is.na(a)
  l.operators5 <- list("is_na" = "is.na", "is_not_na" = "!is.na")
  ## operators acting on multiple values
  l.operators6 <- list("in" = "%in%", "not_in" = "!%in%")
  ## operators based on a trend
  l.operators7 <- list("up" = "upTrend", "down" = "downTrend")

  # javascript boolean to R boolean
  ifelse(value %in% c("true", "false"), toupper(value), value)

  if (operator %in% names(l.operators1)) {
    if (substring(operator, nchar(operator)) == "_") {
      return(paste0(id, l.operators1[[operator]], " `", value, "`"))
    } else {
      return(paste0(id, l.operators1[[operator]], " ", value))
    }
  }
  if (operator %in% names(l.operators2)) {
    return(paste0(l.operators2[[operator]], "(", id, ", ", value, ")"))
  }
  if (operator %in% names(l.operators3)) {
    return(paste0(l.operators3[[operator]], "(", value, ", ", id, ")"))
  }
  if (operator %in% names(l.operators4)) {
    if (operator == "between") {
      #return(glue::glue("between({id}, {value[[1]]}, {value[[2]]})"))
      return(paste0(id, " >= ", value[[1]], " & ", id, " <= ", value[[2]]))
    } else {
      #return(glue::glue("!between({id}, {value[[1]]}, {value[[2]]})"))
      return(paste0("!(", id, " >= ", value[[1]], " & ", id, " <= ", value[[2]], ")"))
    }
  }
  if (operator %in% names(l.operators5)) {
    return(paste0(l.operators5[[operator]], "(", id, ")"))
  }
  if (operator %in% names(l.operators6)) {
    if (operator == "in") {
      return(paste0(id, " %in% c(", paste(value, collapse = ", "), ")"))
    } else {
      return(paste0("!(", id, " %in% c(", paste(value, collapse = ", "), "))"))
    }
  }
  if (operator %in% names(l.operators7)) {
    return(paste0("queryBuilder::", l.operators7[[operator]], "(", paste(gsub('\"', "`", value), collapse = ", "), ")"))
    ## Need to add namespace for defined functions for dplyr filter_ to work
  }
}

#' recurseFilter
#'
#' internal recursive function to process filter
#'
#' @param filter filters output from queryBuilder htmlWidget
#' @param date_format optional date formatting
#' @return string representation of all filters combined
#'
recurseFilter <- function(filter = NULL, date_format = NULL) {
  condition <- list("AND" = "&", "OR" = "|")
  fs <- NULL
  for (i in seq_along(filter$rules)) {
    if (typeof(filter$rules[[i]]$rules) == "list") { # nested filter group
      if (is.null(fs)) {
        fs <- paste0("(", recurseFilter(filter = filter$rules[[i]]), ")") # first filter
      } else {
        fs <- paste(fs, paste0("(", recurseFilter(filter = filter$rules[[i]]), ")"),
          sep = paste0(" ", condition[[filter$condition]], " ")
        ) ## subsequent filters
      }
    } else { # not a nested filter group - process as a single filter
      if (length(filter$rules[[i]]$value) == 0) { # value is list() when checking for NA
        value <- 0
      } else if (filter$rules[[i]]$type == "date") { # treat dates
        if (length(filter$rules[[i]]$value) > 1) {
          value <- purrr::map_chr(filter$rules[[i]]$value, function(x) paste0('as.Date(\"', x, '\", format = ', date_format, ' )')) # date range
        } else {
          value <- paste0('as.Date(\"', filter$rules[[i]]$value, '\", format = \"', date_format, '\")') # single date
        }
      } else if (filter$rules[[i]]$type == "string") { # enclose strings in quotes
        if (length(filter$rules[[i]]$value) > 1) {
          value <- lapply(filter$rules[[i]]$value, function(x) paste0('\"', x, '\"')) # list of strings
        } else {
          value <- paste0('\"', filter$rules[[i]]$value, '\"') # single string
        }
      } else {
        value <- filter$rules[[i]]$value
      }
      if (is.null(fs)) {
        fs <- lookup(filter$rules[[i]]$id, filter$rules[[i]]$operator, value) # first filter
      } else {
        fs <- paste(fs, lookup(filter$rules[[i]]$id, filter$rules[[i]]$operator, value), sep = paste0(" ", condition[[filter$condition]], " ")) # subsequent filters
      }
    }
  }
  return(fs)
}
