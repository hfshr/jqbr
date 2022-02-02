library(shiny)
library(qbr)
library(bslib)


# options(
#     shiny.launch.browser = function(...) .vsc.browser(..., viewer = FALSE),
#     shiny.port = httpuv::randomPort()
# )

invisible(
    lapply(
        list.files("./modules/", full.names = TRUE), source
    )
)


ui <- fluidPage(
    theme = bslib::bs_theme(version = "5"),
    useQueryBuilder(bs_version = "5"),
    fluidRow(
        column(
            width = 12,
            h1("QueryBuilder demo"),
            p(
                "This app demonstrates some of the examples from",
                tags$a(
                    href = "https://querybuilder.js.org/index.html",
                    "https://querybuilder.js.org/index.html"
                ),
                "implemented as R shiny inputs in the {qbr} package",
            ),
            p(
                "Github repo: ",
                tags$a(
                    href = "https://github.com/hfshr/qbr",
                    "https://github.com/hfshr/qbr"
                ),
            ),
            p(
                "Documentation: ",
                tags$a(
                    href = "https://hfshr.github.io/qbr",
                    "https://hfshr.github.io/qbr"
                )
            )
        )
    ),
    fluidRow(
        column(
            width = 12,
            tabsetPanel(
                tabPanel(
                    "Basic",
                    basic_builder_ui("basic")
                ),
                tabPanel(
                    "Plugins",
                    plugin_builder_ui("plugin")
                ),
                tabPanel(
                    "Widgets",
                    widget_builder_ui("widget")
                ),
                tabPanel(
                    "R filters",
                    r_builder_ui("r_filters")
                ),
                tabPanel(
                    "Advanced",
                    advanced_builder_ui("advanced")
                )
            )
        )
    )
)

server <- function(input, output, session) {
    basic_builder_server("basic")
    plugin_builder_server("plugin")
    widget_builder_server("widget")
    r_builder_server("r_filters")
    advanced_builder_server("advanced")
}


shinyApp(ui, server)
