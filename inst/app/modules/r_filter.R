


r_filters <- list(
    list(
        id = "mpg",
        title = "MPG",
        type = "double"
    ),
    list(
        id = "cyl",
        type = "integer",
        input = "radio",
        values = list(
            4,
            6,
            8
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
                    "qbr comes with a helper function",
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
                    return_value = "r_rules"
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
