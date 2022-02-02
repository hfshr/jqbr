# Plugins

queryBuilder provides the ability to use several plugins that enhance the functionality of the defauly builder. See a full list of available plugins [here](https://querybuilder.js.org/demo.html#plugins) Many of these are supported by `qbr` and can be accessed by using a named list in the call to `queryBuilderInput`.

```r
plugins <- list(
  "sortable" = NULL
  "filter-description" = list("mode" = "bootbox")
  "bt-checkbox" = NULL,
  "invert" = NULL
)

ui <- fluidPage(
    useQueryBuilder(),
    queryBuilderInput(
        inputId = "qb",
        plugins = plugins,
        filters = list(
             list(
                 id = "name",
                 title = "Name",
                 type = "string",
                 description = "A description!"
                 )
            )
        )
    )
)

server <- function(input, output){
    observe({
        print(input$qb)
    })
}

shinyApp(ui, server)

```
