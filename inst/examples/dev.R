library(shiny)
library(DT)
library(palmerpenguins)
library(qbr)

filters <- list(
  list(
    id = "species",
    label = "Species",
    type = 'string',
    input = 'select',
    description = "Shift-click to select multiple!",
    values = list("Adelie", "Gentoo", "Chinstrap"),
    multiple = TRUE,
    operators = c('equal', 'not_equal', "in", "not_in")
  ),
  list(
    id = "sex",
    label = "Sex",
    input = "checkbox",
    values = list(
      "male",
      "female"
    ),
    colors = list(
      "success",
      "danger"
    ),
    description = JS(
      "function(rule) {
        if (rule.operator && ['in', 'not_in'].indexOf(rule.operator.type) !== -1) {
          return 'Use a pipe (|) to separate multiple values with \"in\" and \"not in\" operators';
        }
      }")
  ),
  list(
    id = "bill_length_mm",
    label = "Bill length",
    type = "integer",
    validation = list(
      min = 0,
      max = 100
    ),
    plugin = "slider",
    plugin_config = list(
      min = 0,
      max = 100,
      value = 0
    )
  ),
  list(
    id = "year",
    label = "Year",
    type = 'string',
    input = 'select',
    description = "Shift-click to select multiple!",
    values = list("2007", "2008", "2009"),
    multiple = TRUE,
    operators = c('equal', 'not_equal', "in", "not_in")
  )
  )

shiny::shinyApp(
  ui = fluidPage(
    fluidRow(
    column(8,
           queryBuilderOutput("querybuilder",
                                 width = 800,
                                 height = 300)
           )
    ),
  fluidRow(
    verbatimTextOutput("txtFilterList"),
    verbatimTextOutput("fulllist"),
    verbatimTextOutput("txtSQL"),
    tableOutput("txtFilterResult")
  )
  ),
  server = function(input, output, session) {

    output$querybuilder <- renderQueryBuilder({
      queryBuilder(
        filters = filters,
        plugins = list("sortable" = NA,
                       "bt-tooltip-errors" = NA,
                       "bt-checkbox" = list("color" = "primary"),
                       'filter-description' = list("mode" = "bootbox"),
                       "unique-filter" = NA),
        display_errors = TRUE,
        allow_empty = FALSE,
        select_placeholder = "###",
        allow_invalid = TRUE,
        default_condition = "OR"
      )
    })

    output$txtFilterList <- renderPrint({
      req(input$querybuilder_validate)


      filterTable(
        filters = input$querybuilder_out,
        data = palmerpenguins::penguins,
        output = "text"

      )

       input$querybuilder_out
    })


    output$txtFilterResult <- renderTable({
      req(input$querybuilder_validate)
      filterTable(
        filters = input$querybuilder_out,
        data = palmerpenguins::penguins,
        output = "table"
      )
    })


    output$txtSQL <- renderPrint({
      req(input$querybuilder_validate)
      input$querybuilder_sql
    })
  }
)

