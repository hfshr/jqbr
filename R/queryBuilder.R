#' queryBuilder
#'
#' @param filters list of list specifying the available filters in the builder.
#' @param plugins character vector of option plugins
#' @param display_errors When an error occurs on a rule, display an icon with a tooltip
#' explaining the error.
#' @param allow_empty No error will be thrown is the builder is entirely empty.
#'
#' @import htmlwidgets
#'
#' @export
queryBuilder <- function(filters,
                         plugins = NULL,
                         rules = NULL,
                         display_errors = FALSE,
                         allow_empty = FALSE,
                         width = NULL,
                         height = NULL,
                         elementId = NULL) {

  x = list(
    plugins = plugins,
    filters = filters,
    rules = rules,
    display_errors = display_errors,
    allow_empty = allow_empty
  )

  # create widget
  htmlwidgets::createWidget(
    name = 'queryBuilder',
    x,
    width = width,
    height = height,
    package = 'qbr',
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
queryBuilderOutput <- function(outputId, width = '100%', height = '400px'){
  htmlwidgets::shinyWidgetOutput(outputId, 'queryBuilder', width, height, package = 'qbr')
}

#' @rdname queryBuilder-shiny
#' @export
renderQueryBuilder <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, queryBuilderOutput, env, quoted = TRUE)
}
