
filters <- list(
  list(
    id = "name",
    label = "Name",
    type = "string",
    description = "I'm a description!"
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
    description = "I'm another description!",
    operators = c("equal", "not_equal", "in", "not_in", "is_null", "is_not_null")
  ),
  list(
    id = "in_stock",
    label = "In stock",
    type = "integer",
    input = "radio",
    values = list(
      "Yes",
      "No"
    ),
    operators = c("equal", "not_equal")
  ),
  list(
    id = "price",
    label = "Price",
    type = "double",
    validation = list(
      min = 0,
      step = 0.01
    )
  ),
  list(
    id = "id",
    label = "Identifier",
    type = "string",
    placeholder = "____-____-____",
    operators = c("equal", "not_equal")
  )
)



rules_basic <- list(
  condition = "AND",
  rules = list(
    list(
      id = "price",
      operator = "less",
      value = 10.25
    ),
    list(
      condition = "OR",
      rules = list(
        list(
          id = "category",
          operator = "equal",
          value = "Movies"
        ),
        list(
          id = "category",
          operator = "equal",
          value = "Books"
        )
      )
    )
  )
)



basic_builder_ui <- function(id) {
  ns <- NS(id)
  tagList(
    fluidRow(
      column(
        width = 12,
        h2("Basic builder"),
        p("The example below demontrates a querybuilder with default settings.")
      )
    ),
    fluidRow(
      column(
        width = 6,
        h4("Builder"),
        queryBuilderInput(
          inputId = ns("basic"),
          filters = filters,
          rules = rules_basic,
          return_value = "all"
        ),
      ),
      column(
        width = 6,
        h4("Outputs"),
        rule_output_ui(ns("plugin_output"))
      )
    )
  )
}

basic_builder_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    rule_output <- reactive(input$basic)
    rule_output_server("plugin_output", rule_output)
  })
}