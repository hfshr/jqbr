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

By default the output it a string like

```r
"name == \"John\""
```

but other output options are available by using the `return_type` arguments inside the call to `queryBuilderInput`. Available options are:

- `"r_rules"` (default)
- `"rules"` (list - the raw output of queryBuilder)
- `"sql_rules"` (Similar to r_rule but formatted for a SQL query)
- `"all"` (Return all three types in a list)

## Update queryBuilder

You can also use the `updateQueryBuilder` to perform a variety of actions on the builder. Current support actions include reset, destroy, update filters and insert filters. [See here](/references/updateQueryBuilder) for more information.

```r
  observe({
    updateQueryBuilder(
      inputId = "qb",
      reset = TRUE
    )
  }) %>%
    bindEvent(input$reset)

```
