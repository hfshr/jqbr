#' Apply query to a dataframe
#'
#' Filter a dataframe using the output of a queryBuilder. The `return_value`
#' Should be set to `r_rules`, and the list of filters should contain column names
#' that are present in the data as their id value.
#'
#' @param data `data.frame` to filter.
#' @param filters output from queryBuilder when `return_value = "r_rules"`.
#'
#' @return A filtered version of the input `data.frame`
#'
#' @examples
#'
#' library(shiny)
#' library(jqbr)
#'
#' filters <- list(
#'   list(
#'     id = "cyl",
#'     type = "integer",
#'     input = "radio",
#'     values = list(
#'       4,
#'       6,
#'       8
#'     )
#'   )
#' )
#'
#' ui <- fluidPage(
#'   queryBuilderInput(
#'     inputId = "r_filter",
#'     filters = filters,
#'     return_value = "r_rules"
#'   ),
#'   tableOutput("cars")
#' )
#'
#' server <- function(input, output) {
#'   output$cars <- renderTable({
#'     filter_table(mtcars, input$r_filter)
#'   })
#' }
#'
#'
#' if (interactive()) {
#'   shinyApp(ui, server)
#' }
#' @export
filter_table <- function(data = NULL,
                         filters = NULL) {
  if (is.null(filters) || !length(filters) || is.null(data)) {
    return(data)
  }
  df <- subset(data, eval(parse(text = filters)))
  return(df)
}


#' lookup
#'
#' internal function to create a filter condition based on id,
#' operator and value
#'
#' @param id data frame column id
#' @param operator filter operator as defined within queryBuilder
#' @param value filter value
#' @return string representation of a single filter
#'
#' @noRd
#'
lookup <- function(id, operator, value) {
  id <- paste0("`", id, "`")
  ## triple style operator, eg a = 1
  op_1 <- list(
    "equal" = "==",
    "not_equal" = "!=",
    "less" = "<",
    "less_or_equal" = "<=",
    "greater" = ">",
    "greater_or_equal" = ">=",
    "equal_" = "==",
    "not_equal_" = "!=",
    "less_" = "<",
    "less_or_equal_" = "<=",
    "greater_" = ">",
    "greater_or_equal_" = ">="
  )
  ## functional style operator, eg startswith(a, value)
  op_2 <- list(
    "begins_with" = "startsWith",
    "not_begins_with" = "!startsWith",
    "ends_with" = "endsWith",
    "not_ends_with" = "!endsWith"
  )
  ## grep style operator, eg grepl(value, a)
  op_3 <- list(
    "contains" = "grepl",
    "not_contains" = "!grepl"
  )
  ## two-value style operator, eg a > 10 & a < 20
  op_4 <- list(
    "between" = "between",
    "not_between" = "not_between"
  )
  ## simple boolean function, eg is.na(a)
  op_5 <- list(
    "is_na" = "is.na",
    "is_not_na" = "!is.na",
    "is_null" = "is.null",
    "is_not_null" = "!is.null"
  )
  ## operators acting on multiple values
  op_6 <- list(
    "in" = "%in%",
    "not_in" = "!%in%"
  )

  op_7 <- list(
    "is_empty" = "== \"\"",
    "is_not_empty" = "!= \"\""
  )



  # javascript boolean to R boolean
  ifelse(value %in% c("true", "false"), toupper(value), value)

  if (operator %in% names(op_1)) {
    if (substring(operator, nchar(operator)) == "_") {
      return(paste0(id, op_1[[operator]], " `", value, "`"))
    } else {
      return(paste0(id, op_1[[operator]], " ", value))
    }
  }
  if (operator %in% names(op_2)) {
    return(paste0(op_2[[operator]], "(", id, ", ", value, ")"))
  }
  if (operator %in% names(op_3)) {
    return(paste0(op_3[[operator]], "(", value, ", ", id, ")"))
  }
  if (operator %in% names(op_4)) {
    if (operator == "between") {
      return(paste0(
        id,
        " >= ",
        value[[1]],
        " & ",
        id,
        " <= ",
        value[[2]]
      ))
    } else {
      return(paste0(
        "!(",
        id,
        " >= ",
        value[[1]],
        " & ",
        id,
        " <= ",
        value[[2]],
        ")"
      ))
    }
  }
  if (operator %in% names(op_5)) {
    return(paste0(op_5[[operator]], "(", id, ")"))
  }
  if (operator %in% names(op_6)) {
    if (operator == "in") {
      return(paste0(
        id,
        " %in% c(",
        paste(value, collapse = ", "),
        ")"
      ))
    } else {
      return(paste0(
        "!(",
        id,
        " %in% c(",
        paste(value, collapse = ", "),
        "))"
      ))
    }
  }
  if (operator %in% names(op_7)) {
    return(paste(id, op_7[[operator]]))
  }
}

#' recurse_filter
#'
#' internal recursive function to process filter
#'
#' @param filter filters output from queryBuilder htmlWidget
#' @param date_format optional date formatting
#' @return string representation of all filters combined
#'
#' @noRd
#'
recurse_filter <- function(filter = NULL, date_format = NULL) {
  condition <- list("AND" = "&", "OR" = "|")
  fs <- NULL
  for (i in seq_along(filter$rules)) {
    if (typeof(filter$rules[[i]]$rules) == "list") { # nested filter group
      if (is.null(fs)) {
        fs <- paste0(
          "(",
          recurse_filter(filter = filter$rules[[i]]),
          ")"
        ) # first filter
      } else {
        fs <- paste(
          fs,
          paste0(
            "(",
            recurse_filter(filter = filter$rules[[i]]),
            ")"
          ),
          sep = paste0(" ", condition[[filter$condition]], " ")
        ) ## subsequent filters
      }
    } else { # not a nested filter group - process as a single filter
      if (length(filter$rules[[i]]$value) == 0) {
        # value is list() when checking for NA
        value <- 0
      } else if (filter$rules[[i]]$type == "date") {
        # treat dates
        if (length(filter$rules[[i]]$value) > 1) {
          value <- lapply(
            filter$rules[[i]]$value,
            function(x) {
              paste0(
                '\"',
                x,
                '\"'
              )
            }
          ) # date range
        } else {
          value <- paste0(
            '\"',
            filter$rules[[i]]$value,
            '\"'
          )
        }
      } else if (filter$rules[[i]]$type == "string") {
        # enclose strings in quotes
        if (length(filter$rules[[i]]$value) > 1) {
          value <- lapply(
            filter$rules[[i]]$value,
            function(x) paste0('\"', x, '\"')
          ) # list of strings
        } else {
          # single string
          value <- paste0('\"', filter$rules[[i]]$value, '\"')
        }
      } else {
        value <- filter$rules[[i]]$value
      }
      if (is.null(fs)) {
        fs <- lookup(
          filter$rules[[i]]$id,
          filter$rules[[i]]$operator,
          value
        ) # first filter
      } else {
        fs <- paste(
          fs,
          lookup(
            filter$rules[[i]]$id,
            filter$rules[[i]]$operator,
            value
          ),
          sep = paste0(" ", condition[[filter$condition]], " ")
        )
      }
    }
  }
  return(fs)
}