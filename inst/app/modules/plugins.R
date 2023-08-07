plugins <- list(
  "sortable" = NULL,
  "filter-description" = list("mode" = "bootbox"),
  "bt-checkbox" = NULL,
  "invert" = NULL,
  "unique-filter" = NULL,
  "bt-tooltip-errors" = NULL
)
rules_plugins <- list(
  condition = "AND",
  rules = list(
    list(
      id = "name",
      operator = "equal",
      value = "hfshr"
    ),
    list(
      condition = "OR",
      rules = list(
        list(
          id = "category",
          operator = "in",
          value = c("Books", "Movies")
        ),
        list(
          id = "in_stock",
          operator = "equal",
          value = "Yes"
        )
      )
    )
  )
)



plugin_builder_ui <- function(id) {
  ns <- NS(id)
  tagList(
    fluidRow(
      column(
        width = 12,
        h2("Plugins"),
        p(
          "jqbr supports the use of plugins that enhance the builders
                functionality.
                For more information about the plugins see ",
          tags$a(href = "https://querybuilder.js.org/plugins.html", "here")
        )
      )
    ),
    fluidRow(
      column(
        width = 6,
        h4("Builder"),
        queryBuilderInput(
          inputId = ns("plugins"),
          plugins = plugins,
          filters = filters,
          rules = rules_plugins,
          display_errors = TRUE,
          return_value = "all"
        ),
        fluidRow(
          column(
            width = 12,
            div(
              style = "display: inline-block;",
              actionButton(
                ns("reset"),
                "Reset",
                class = "btn-danger"
              ),
              actionButton(
                ns("set_rules"),
                "Set rules",
                class = "btn-warning"
              )
            )
          )
        )
      ),
      column(
        width = 6,
        h4("Outputs"),
        rule_output_ui(ns("plugin_output"))
      )
    )
  )
}

plugin_builder_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    rule_output <- reactive(input$plugins)
    rule_output_server("plugin_output", rule_output)


    observeEvent(input$reset, {
      updateQueryBuilder(
        inputId = "plugins",
        reset = TRUE
      )
    })

    observeEvent(input$set_rules, {
      updateQueryBuilder(
        inputId = "plugins",
        setRules = rules_plugins
      )
    })
  })
}