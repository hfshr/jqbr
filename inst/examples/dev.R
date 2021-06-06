library(shiny)


filt <- list(
  list(
    id = "mpgx",
    label = "Mile per gallon",
    type = "integer",
    description = "This filter is <b>awesome</b> !",
    unique = T,
    operator = c('equal', 'not_equal')
  ),
  list(
    id = "in_stock",
    label = "In stock",
    type = "integer",
    input = "checkbox",
    values = list(
      "Yes",
      "No"
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
    id = "mpg",
    label = "Slider",
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
    id = "date",
    label = "Datepicker",
    type = "date",
    validation = list(
      format = "YYYY-MM-DD"
    ),
    plugin = "datepicker",
    plugin_config = list(
      format = "yyyy-mm-dd",
      todayBtn = "linked",
      todayHighlight = T,
      autoclose = T
    )
  ),
  list(
    id = 'state',
    label = 'State',
    icon = 'glyphicon glyphicon-globe',
    type = 'string',
    input = 'select',
    multiple = T,
    plugin = 'selectize',
    plugin_config = list(
      valueField = 'id',
      labelField = 'name',
      searchField = 'name',
      sortField = 'name',
      options = list(
          list( id = "AL", name = "Alabama" ),
          list( id = "AK", name = "Alaska" ),
          list( id = "AZ", name = "Arizona" ),
          list( id = "AR", name = "Arkansas" ),
          list( id = "CA", name = "California" ),
          list( id = "CO", name = "Colorado" ),
          list( id = "CT", name = "Connecticut" ),
          list( id = "DE", name = "Delaware" ),
          list( id = "DC", name = "District of Columbia" ),
          list( id = "FL", name = "Florida" ),
          list( id = "GA", name = "Georgia" ),
          list( id = "HI", name = "Hawaii" ),
          list( id = "ID", name = "Idaho" )
      )
    )
  )
  )

library(shiny)
library(bs4Dash)


shinyApp(
  ui = dashboardPage(
    header = dashboardHeader(),
    sidebar = dashboardSidebar(),
    body = dashboardBody(
        fluidRow(
          column(8, queryBuilderOutput("querybuilder",
                                       width = 600,
                                       height = 200))
          ),
      verbatimTextOutput("txtFilterList"),
      verbatimTextOutput("fulllist"),
      verbatimTextOutput("txtSQL"),
      verbatimTextOutput("txtMongo")
    )
  ),
  server = function(input, output) {

    output$querybuilder <- renderQueryBuilder({
      queryBuilder(
        filters = filt,
        plugins = list("sortable" = NA,
                       "bt-tooltip-errors" = NA,
                       "bt-checkbox" = list("color" = "primary"),
                       'filter-description' = list("mode" = "bootbox"),
                       "unique-filter" = NA,
                       "invert" = NA,
                       "not-group" = NA),
        display_errors = TRUE,
        allow_empty = TRUE
      )
    })



    output$txtFilterList <- renderPrint({
      req(input$querybuilder_validate)
      filterTable(
        filters = input$querybuilder_out,
        data = mtcars,
        output = "text"
      )
    })

    output$fulllist <- renderPrint({
      req(input$querybuilder_validate)
      input$querybuilder_out
    })


    output$txtSQL <- renderPrint({
      req(input$querybuilder_validate)
      input$querybuilder_sql
    })

    output$txtMongo <- renderPrint({
      req(input$querybuilder_validate)
      input$querybuilder_mongo
    })

  }
)



shiny::shinyApp(
  ui = fluidPage(
    fluidRow(
    column(8,
           offset = 2,
           queryBuilderOutput("querybuilder",
                                 width = 600,
                                 height = 300)
           )
    ),
  fluidRow(
    verbatimTextOutput("txtFilterList"),
    verbatimTextOutput("fulllist"),
    verbatimTextOutput("txtSQL")
  )
  ),
  server = function(input, output, session) {

    output$querybuilder <- renderQueryBuilder({
      queryBuilder(
        filters = filt,
        plugins = list("sortable" = NA,
                       "bt-tooltip-errors" = NA,
                       "bt-checkbox" = list("color" = "primary"),
                       'filter-description' = list("mode" = "bootbox"),
                       "unique-filter" = NA,
                       "invert" = NA,
                       "not-group" = NA),
        display_errors = TRUE,
        allow_empty = FALSE
      )
    })

    output$txtFilterList <- renderPrint({
      req(input$querybuilder_validate)
      filterTable(
        filters = input$querybuilder_out,
        data = mtcars,
        output = "text"
      )
    })

    output$fulllist <- renderPrint({
      req(input$querybuilder_validate)
      input$querybuilder_out
    })


    output$txtSQL <- renderPrint({
      req(input$querybuilder_validate)
      input$querybuilder_sql
    })
  }
)

