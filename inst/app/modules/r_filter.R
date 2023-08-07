


r_filters <- list(
  list(
    id = "mpg",
    title = "MPG",
    type = "double",
    plugin = "slider",
    operators = c("greater", "less", "between"),
    plugin_config = list(
      min = min(mtcars$mpg) - 1,
      max = max(mtcars$mpg) + 1,
      value = 20
    )
  ),
  list(
    id = "cyl",
    type = "integer",
    input = "checkbox",
    values = list(
      4,
      6,
      8
    ),
    operators = c("equal", "not_equal", "in")
  ),
  list(
    id = "disp",
    operators = c("is_na", "is_not_na")
  )
)

rules_r <- list(
  condition = "AND",
  rules = list(
    list(
      id = "mpg",
      operator = "greater",
      value = 20
    ),
    list(
      id = "cyl",
      operator = "in",
      value = 4
    ),
    list(
      id = "disp",
      operator = "is_not_na"
    )
  )
)

r_builder_ui <- function(id) {
  ns <- NS(id)
  tagList(
    fluidRow(
      column(
        width = 12,
        h2("R filter"),
        p(
          "jqbr comes with a helper function",
          tags$code("filter_table"),
          "to automatically apply the output to a table in R"
        )
      )
    ),
    fluidRow(
      column(
        width = 6,
        h4("Builder"),
        queryBuilderInput(
          inputId = ns("r_filter"),
          filters = r_filters,
          return_value = "r_rules",
          display_errors = TRUE,
          rules = rules_r,
          add_na_filter = TRUE
        ),
      ),
      column(
        width = 6,
        h4("Outputs"),
        tableOutput(
          ns("cars")
        )
      )
    )
  )
}

r_builder_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    output$cars <- renderTable({
      filter_table(mtcars, input$r_filter)
    })
  })
}