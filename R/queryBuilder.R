#' queryBuilder
#'
#' Creates the queryBuidler widget. For more information about the options
#' see https://querybuilder.js.org/#usage
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
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param elementId string. Widget ID.
#'
#' @import htmlwidgets
#'
#' @seealso https://querybuilder.js.org/#usage
#'
#' @examples
#'
#' ## Only run examples in interactive R sessions
#' if (interactive()) {
#'
#'   ## Define a set of filters
#'
#'   filters <- list(
#'     list(
#'       id = "species",
#'       label = "Species",
#'       type = "string",
#'       input = "select",
#'       description = "Shift-click to select multiple!",
#'       values = list("Adelie", "Gentoo", "Chinstrap"),
#'       multiple = TRUE,
#'       operators = c("equal", "not_equal", "in", "not_in")
#'     )
#'   )
#'
#'   ## Useage within a shiny app
#'   library(shiny)
#'   library(qbr)
#'
#'   shinyApp(
#'     ui = fluidPage(
#'       queryBuilderOutput("qbr",
#'         width = 800,
#'         height = 300
#'       ),
#'       fluidRow(
#'         tableOutput("FilterResult")
#'       )
#'     ),
#'     server = function(input, output, session) {
#'       output$qbr <- renderQueryBuilder({
#'         queryBuilder(
#'           filters = filters,
#'           plugins = list(
#'             "sortable" = NA,
#'             "bt-tooltip-errors" = NA,
#'             "bt-checkbox" = list("color" = "primary"),
#'             "filter-description" = list("mode" = "bootbox"),
#'             "unique-filter" = NA
#'           ),
#'           display_errors = TRUE,
#'           allow_empty = FALSE,
#'           select_placeholder = "###"
#'         )
#'       })
#'
#'       output$FilterResult <- renderTable({
#'         req(input$qbr_validate)
#'         filterTable(
#'           filters = input$qbr_out,
#'           data = palmerpenguins::penguins,
#'           output = "table"
#'         )
#'       })
#'     }
#'   )
#' }
#' @export
queryBuilder <- function(filters,
                         plugins = NULL,
                         rules = NULL,
                         display_errors = FALSE,
                         optgroups = NULL,
                         default_filter = NULL,
                         sort_filters = FALSE,
                         allow_empty = FALSE,
                         allow_groups = TRUE,
                         conditions = c("AND", "OR"),
                         select_placeholder = "------",
                         lang = NULL,
                         width = NULL,
                         height = NULL,
                         elementId = NULL) {
  x <- list(
    plugins = plugins,
    filters = filters,
    rules = rules,
    display_errors = display_errors,
    optgroups = optgroups,
    default_filter = default_filter,
    sort_filters = sort_filters,
    allow_empty = allow_empty,
    allow_groups = allow_groups,
    conditions = conditions,
    select_placeholder = select_placeholder,
    lang = lang
  )

  # create widget
  htmlwidgets::createWidget(
    name = "queryBuilder",
    x,
    width = width,
    height = height,
    package = "qbr",
    elementId = elementId
  )
}

#' Shiny bindings for queryBuilder
#'
#' Output and render functions for using queryBuilder within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a queryBuilder
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name queryBuilder-shiny
#'
#' @export
queryBuilderOutput <- function(outputId, width = "100%", height = "400px") {
  htmlwidgets::shinyWidgetOutput(outputId, "queryBuilder", width, height, package = "qbr")
}

#' @rdname queryBuilder-shiny
#' @export
renderQueryBuilder <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) {
    expr <- substitute(expr)
  } # force quoted
  htmlwidgets::shinyRenderWidget(expr, queryBuilderOutput, env, quoted = TRUE)
}


