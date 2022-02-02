# Advanced

It is possible to use custom javascript function to further enhance the builder.

For example, this example uses a custom description when "in" or "not in" operators are used.

```r

filters <- list(
  list(
    id = "name",
    label = "Name",
    type = "string",
    description =
    "function(rule) {
    if (rule.operator && ['in', 'not_in'].indexOf(rule.operator.type) !== -1) {
      return 'Use a pipe (|) to separate multiple values with in and not in operators';}}"
  )
)

ui <- fluidPage(
    useQueryBuilder(),
    queryBuilderInput(
        inputId = "qb",
        plugins = list(
          "filter-description" = list("mode" = "inline")
          ),
        filters = filters
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
