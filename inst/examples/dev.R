library(shiny)
library(qbr)

filt <- list(
  list(
    id = "mpgx",
    label = "Mile per gallon",
    type = "integer",
    description = 'This filter is <b>awesome</b> !',
    unique = T,
    operator = c('equal', 'not_equal')
  ),
  list(
    id = "in_stock",
    label = "In stock",
    type = "string",
    input = "radio",
    values = list(
      "Yes",
      "No"
    ),
    colors = list(
      "success",
      "danger"
    ),
    description = 'This filter also uses Awesome Bootstrap Checkboxes'
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
      format = "YYYY/MM/DD"
    ),
    plugin = "datepicker",
    plugin_config = list(
      format = "yyyy/mm/dd",
      todayBtn = "linked",
      todayHighlight = T,
      autoclose = T
    )
  ),
  list(
    id=  'category',
    label = 'Selectize',
    type = 'string',
    plugin = 'selectize',
    values = list(
      "A",
      "B",
      "C"
    ),
    plugin_config = list(
      valueField = 'id',
      labelField = 'name',
      searchField = 'name',
      sortField = 'name'
  ))
)



shiny::shinyApp(
  ui <- fluidPage(
    fluidRow(
      column(8, qbr::queryBuilderOutput("querybuilder", width = 800, height = 300))
    ),
    actionButton("test", "go"),
    verbatimTextOutput("txtFilterList"),
    verbatimTextOutput("fulllist"),
    verbatimTextOutput("txtSQL")
  ),
  server <- function(input, output, session) {
    output$querybuilder <- renderQueryBuilder({
      queryBuilder(
        filters = filt,
        plugins = c(
          "bt-tooltip-errors",
          "bt-checkbox",
          "chosen-selectpicker",
          "sortable",
          'filter-description',
          'unique-filter'
        ),
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
  }
)

#
#
# x <- stringr::str_split("`mpg`== 10 & `mpg`== 11",
#                         pattern = " & ",
#                         simplify = TRUE)
# x <- unlist(strsplit("`mpg`== 10 & `mpg`== 11", " & "))
#
#
#
# trimws(gsub("`", " ", x))
#
# stringr::str_squish(stringr::str_replace_all(x, "`", " "))


