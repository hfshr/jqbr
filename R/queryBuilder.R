#' queryBuilderInput
#'
#' Shiny input for queryBuilder .
#'
#' @param filters list of list specifying the available filters in the builder.
#' See example for a See https://querybuilder.js.org/#filters
#' for details on the possible options
#' @param rules Initial set of rules.
#' By default the builder will contain one empty rule
#' @param plugins list of optional plugins.
#' @param display_errors bool. If `TRUE`, when an error occurs on a rule, display an icon with a tooltip
#' explaining the error.
#' @param optgroups List of groups in the filters and operators dropdowns.
#' @param default_filter string. The `id` of the default filter for any new rule.
#' @param sort_filters boolean|function. Sort filters alphabetically, or with a custom JS function.
#' @param allow_empty bool. If `TRUE`, no error will be thrown if the builder is entirely empty.
#' @param allow_groups boolean|int. Number of allowed nested groups. `TRUE` for no limit.
#' @param conditions string. Array of available group conditions. Use the `lang` option to change the label.
#' @param select_placeholder string. Label of the "no filter" option.
#' @param lang Additional/overwrites translation strings.
#'
#' @examples
#' library(shiny)
#'
#' ui <- fluidPage(
#'   queryBuilderInput("qb")
#' )
#'
#' server <- function(input, output) {
#'   observeEvent(input$qb, {
#'     print(input$qb)
#'   })
#' }
#'
#' if (interactive()) {
#'   shinyApp(ui, server)
#' }
#' @importFrom shiny tags tagList
#'
#' @export
queryBuilderInput <- function(inputId,
                              width = "100%",
                              filters,
                              plugins = NULL,
                              rules = NULL,
                              optgroups = NULL,
                              default_filter = NULL,
                              sort_filters = FALSE,
                              allow_groups = TRUE,
                              allow_empty = FALSE,
                              display_errors = FALSE,
                              conditions = c("AND", "OR"),
                              default_condition = "AND",
                              inputs_separator = ",",
                              display_empty_filter = TRUE,
                              select_placeholder = "------",
                              operators = NULL) {
  stopifnot(!missing(inputId))
  stopifnot(!missing(filters))

  validate_filters(filters)

  options <- list(
    filters = filters,
    plugins = plugins,
    rules = rules,
    optgroups = optgroups,
    default_filter = default_filter,
    sort_filters = sort_filters,
    allow_groups = allow_groups,
    allow_empty = allow_empty,
    display_errors = display_errors,
    conditions = conditions,
    default_condition = default_condition,
    inputs_separator = inputs_separator,
    display_empty_filter = display_empty_filter,
    select_placeholder = select_placeholder,
    operators = operators
  )

  plugin_names <- find_plugins(plugins)
  print(plugin_names)

  options <- dropNulls(options)

  options <- jsonlite::toJSON(
    options,
    auto_unbox = TRUE,
    json_verbatim = TRUE
  )

  qb <- tags$div(
    class = "form-group shiny-input-container",
    style = if (!is.null(width)) {
      paste0("width: ", shiny::validateCssUnit(width), ";")
    },
    tags$div(
      id = inputId,
      class = "queryBuilderBinding",
      tags$script(
        type = "application/json",
        `data-for` = inputId,
        options
      )
    )
  )


  shiny::tagList(
    plugin_deps(plugin_names),
    qb,
  )
}

useQueryBuilder <- function(bs_version = 3, sortable = FALSE) {
  query_builder_bs <- sprintf(
    "query-builder-bs%s.standalone.min.js",
    bs_version
  )

  querybuilder <- htmltools::htmlDependency(
    name = "queryBuilderBinding",
    version = "1.0.0",
    src = c(file = system.file("packer", package = "qbr")),
    script = c("queryBuilder.js", query_builder_bs),
    stylesheet = "query-builder.standalone.min.css"
  )


  querybuilder
}




#' updateQueryBuilder
#'
#' Update a queryBuilder with available methods.
#'
#' @param setFilters
#'
#'
updateQueryBuilder <- function(inputId,
                               setFilters = NULL,
                               addFilters = NULL,
                               destroy = FALSE,
                               reset = FALSE,
                               session = getDefaultReactiveDomain()) {
  message <- list(
    setFilters = setFilters,
    addFilters = addFilters,
    destroy = destroy,
    reset = reset
  )

  message <- jsonlite::toJSON(
    message,
    null = "null",
    auto_unbox = TRUE
  )

  session$sendInputMessage(inputId, message = message)
}



# x <- list(
#   list(id = "a"),
#   list(id = "b"),
#   "a"
# )



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

dropNulls <- function(x) {
  x[!vapply(x, is.null, FUN.VALUE = logical(1))]
}






# sortable_dep <- function(sortable) {
#   if (sortable) {
#     htmltools::htmlDependency(
#       name = "interactjs",
#       version = "1.10.11",
#       src = c(href = "https://cdnjs.cloudflare.com/ajax/libs/interact.js/1.10.11/"),
#       script = "interact.min.js"
#     )
#   }
# }
