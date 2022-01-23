library(shiny)

description <- htmlwidgets::JS("function(rule) {
  return 'The description for ' + (rule.operator ? rule.operator.type : 'anything');
  }")
filters <- list(
  list(
    id = "name",
    label = "Name",
    type = "string",
    description = description
  ),
  list(
    id = "category",
    label = "Category",
    type = "integer",
    input = "select",
    values = list(
      "Books",
      "Movies",
      "Music",
      "Tools",
      "Goodies",
      "Clothes"
    ),
    operators = c(
      "equal",
      "not_equal",
      "in",
      "not_in",
      "is_null",
      "is_not_null"
    )
  )
)


rules <- list(
  rules = list(
    list(
      id = "name",
      operator = "equal",
      value = "hello"
    )
  )
)

plugins <- list(
  # sortable = NULL
  "filter-description" = list("mode" = "inline")
)
options(
  shiny.launch.browser = function(...) .vsc.browser(..., viewer = FALSE),
  shiny.port = httpuv::randomPort()
)

ui <- fluidPage(
  theme = bslib::bs_theme(version = 5),
  useQueryBuilder(bs_version = 5),
  fluidRow(
    column(
      width = 6,
      queryBuilderInput("qb",
        filters = filters,
        rules = rules,
        plugins = plugins,
      )
    ),
    column(
      width = 4,
      actionButton("update", "Update")
    )
  )
)

server <- function(input, output, session) {
  observe({
    print(input$qb)
  })

  new_rules <- list(
    list(
      id = "go",
      type = "string"
    )
  )

  observe({
    updateQueryBuilder(
      inputId = "qb",
      setFilters = new_rules
    )
  }) |>
    bindEvent(input$update)

  session$onSessionEnded(function() {
    shiny::stopApp()
  })
}

shinyApp(ui = ui, server = server)


htmlwidgets::JSEvals()
