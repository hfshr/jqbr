#' useQueryBuilder
#'
#' Make a call to `useQueryBuilder` in your ui code to load the
#' required dependencies for the queryBuilder and optionally specify the
#' bootstrap version to use.
#'
#' @param bs_version The version of bootstrap to use with the builder.
#' Possible values are "3", "4" or "5"
#'
#' @return list. html dependency for queryBuilderBinding.
#' See [htmltools::htmlDependency()] for further information.
#'
#' @export
useQueryBuilder <- function(bs_version = c("3", "4", "5")) {
  bs_version <- match.arg(bs_version)

  query_builder_bs <- sprintf(
    "query-builder-bs%s.standalone.min.js",
    bs_version
  )
  query_builder_css <- sprintf(
    "query-builder-bs%s.standalone.min.css",
    bs_version
  )


  htmltools::htmlDependency(
    name = "queryBuilderBinding",
    version = "1.0.0",
    src = c(file = system.file("packer", package = "jqbr")),
    script = c("queryBuilder.js", query_builder_bs),
    stylesheet = query_builder_css
  )
}


#' queryBuilderInput
#'
#' Shiny input bindings for queryBuilder.
#'
#' @param inputId string. Input id for the builder.
#' @param width Width of the builder. Default if "100%".
#' @param filters list of list specifying the available filters in the builder.
#' See example for a See https://querybuilder.js.org/#filters for details on the possible options
#' @param rules Initial set of rules.
#' By default the builder will contain one empty rule
#' @param plugins list of optional plugins.
#' @param display_errors boolean. If `TRUE`, when an error occurs on a rule,
#' display an icon with a tooltip explaining the error.
#' @param optgroups List of groups in the filters and operators dropdowns.
#' @param default_filter string. The `id` of the default filter for any new rule.
#' @param sort_filters boolean \| string. Sort filters alphabetically,
#'  or with a custom JS function.
#' @param allow_empty boolean. If `TRUE`, no error will be thrown if the builder
#' is entirely empty.
#' @param allow_groups boolean \| integer. Number of allowed nested groups.
#' `TRUE` for no limit.
#' @param conditions string. Array of available group conditions. Use the
#' `lang` option to change the label.
#' @param default_condition Default active condition. Default 'AND'.
#' @param inputs_separator string used to separate multiple inputs (for between operator).
#' default is ",".
#' @param display_empty_filter boolean. Default `TRUE`. Add an empty option with `select_placeholder` string
#' to the filter dropdowns. If the empty filter is disabled and no `default_filter`
#' is defined, the first filter will be loaded when adding a rule.
#' @param select_placeholder string. Label of the "no filter" option.
#' @param operators NULL or list. If a list, format should follow that described
#' here: https://querybuilder.js.org/#operators
#' @param return_value string. On of `"r_rules"`, `"rules"`, `"sql_rules"`
#' or `"all"`. Default "r_rules". Determines the return value from the builder
#' accessed with input$<builder_id> in shiny server
#' @param add_na_filter bool. Default is FALSE .If `TRUE`, `"is_na"` and `"is_not_na"`
#'  are added to the global filter list for testing for NA values. Only works when
#' `return_type` is "rules" or "r_rules".
#'
#' @return A [htmltools::tagList()] containing the queryBuilder
#' dependencies and configuration that can be added to a [shiny] UI definition.
#'
#' @examples
#' library(shiny)
#' library(jqbr)
#'
#' ui <- fluidPage(
#'   useQueryBuilder(),
#'   queryBuilderInput(
#'     inputId = "qb",
#'     filters = list(
#'       list(
#'         id = "name",
#'         type = "string"
#'       )
#'     )
#'   )
#' )
#'
#' server <- function(input, output) {
#'   observeEvent(input$qb, {
#'     print(input$qb)
#'   })
#' }
#'
#' # Add is_na filter
#'
#' ui <- fluidPage(
#'   useQueryBuilder(),
#'   queryBuilderInput(
#'     inputId = "qb",
#'     add_na_filter = TRUE,
#'     return_value = "r_rules",
#'     filters = list(
#'       list(
#'         id = "name",
#'         type = "string"
#'       )
#'     )
#'   )
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
#'
#' @importFrom htmltools tags tagList
#' @importFrom jsonlite toJSON
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
                              operators = NULL,
                              add_na_filter = FALSE,
                              return_value = c("r_rules", "rules", "sql", "all")) {
  stopifnot(!missing(inputId))
  stopifnot(!missing(filters))

  validate_filters(filters)
  validate_plugins(plugins)

  if (!is.null(operators) && typeof(operators) != "list") {
    stop(
      "`operator` value must be a list or NULL.",
      call. = FALSE
    )
  }

  if (add_na_filter && return_value %in% c("all", "sql")) {
    stop(
      "Operators must not include `is_na` or `is_not_na`
      when using return_type \"all\" or \"sql\"",
      call. = FALSE
    )
  }

  if (is.null(operators)) {
    operators <- operator_list(add_na_filter = add_na_filter)
  }

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
    lang = list(
      operators = list(
        "is_na" = "is NA",
        "is_not_na" = "is not NA"
      )
    ),
    operators = operators
  )

  plugin_names <- find_plugins(plugins)

  return_value <- match.arg(return_value)


  options <- drop_nulls(options)


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
      `data-return` = return_value,
      tags$script(
        type = "application/json",
        `data-for` = inputId,
        options
      )
    )
  )

  htmltools::tagList(
    plugin_deps(plugin_names),
    widget_deps(filters),
    qb,
  )
}


#' updateQueryBuilder
#'
#' Update a queryBuilder with available methods.
#'
#' @param inputId inputId of builder to update.
#' @param setFilters list of lists container new filters.
#' @param addFilter Named list containing `filter` and `position` elements.
#' `filter` should be a list contianing a list which has the new filter to add.
#' `position` can be a string of either "start" or "end" or a integer specifying the position
#' to insert the rule. If position if ommited, filter will be inserted at the end.
#' @param setRules List of rules apply to the builder.
#' @param destroy bool. `TRUE` to destory filter.
#' @param reset bool. `TRUE` to reset filter.
#' @param session The session object passed to function given
#' to shinyServer. Default is getDefaultReactiveDomain().
#'
#' @importFrom shiny getDefaultReactiveDomain
#'
#' @return An updated [queryBuilderInput()]
#'
#' @examples
#' library(shiny)
#' library(jqbr)
#'
#' # Button to reset the build an remove all rules
#' ui <- fluidPage(
#'   useQueryBuilder(),
#'   queryBuilderInput(
#'     inputId = "qb",
#'     filters = list(
#'       list(
#'         id = "name",
#'         type = "string"
#'       )
#'     )
#'   ),
#'   actionButton("reset", "Reset")
#' )
#'
#' server <- function(input, output) {
#'   observeEvent(input$reset, {
#'     updateQueryBuilder(
#'       inputId = "qb",
#'       reset = TRUE
#'     )
#'   })
#' }
#'
#' if (interactive()) {
#'   shinyApp(ui, server)
#' }
#' @export
updateQueryBuilder <- function(inputId,
                               setFilters = NULL,
                               addFilter = NULL,
                               setRules = NULL,
                               destroy = FALSE,
                               reset = FALSE,
                               session = shiny::getDefaultReactiveDomain()) {
  message <- list(
    setFilters = setFilters,
    addFilter = addFilter,
    setRules = setRules,
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