
rule_output_ui <- function(id) {
  ns <- NS(id)
  tagList(
    tabsetPanel(
      tabPanel(
        "R",
        verbatimTextOutput(ns("r_rules"))
      ),
      tabPanel(
        "SQL",
        verbatimTextOutput(ns("sql_rules"))
      ),
      tabPanel(
        "Rules",
        verbatimTextOutput(ns("rules"))
      )
    )
  )
}

rule_output_server <- function(id, qb_id) {
  moduleServer(id, function(input, output, session) {
    output$rules <- renderPrint({
      qb_id()[["rules"]]
    })
    output$r_rules <- renderPrint({
      qb_id()[["r_rules"]]
    })
    output$sql_rules <- renderPrint({
      qb_id()[["sql_rules"]]
    })
  })
}