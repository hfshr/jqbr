# Basic usage

To use `qbr`, include `useQueryBuilder` in your UI, and then use `queryBuilderInput` to initiate the builder. Only the `inputId` and list of `filters` are required.

```r

library(shiny)
library(qbr)

ui <- fluidPage(
    useQueryBuilder(),
    queryBuilderInput(
        inputId = "qb",
        filters = list(
             list(
                 id = "name",
                 title = "Name",
                 type = "string"
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

## Update queryBuilder

You can also use the `updateQueryBuilder` to perform a variety of actions on the builder. Current support actions include reset, destroy, update rules and insert rules.

```r
  observe({
    updateQueryBuilder(
      inputId = "qb",
      setFilters = new_rules
    )
  }) %>%
    bindEvent(input$update)

```
