# `filter_table`

Apply query to a dataframe


## Description

Filter a dataframe using the output of a queryBuilder. The `return_value` 
 Should be set to `r_rules` , and the list of filters should contain column names
 that are present in the data as their id value.


## Usage

```r
filter_table(data = NULL, filters = NULL)
```


## Arguments

Argument      |Description
------------- |----------------
`data`     |     `data.frame` to filter.
`filters`     |     output from queryBuilder when `return_value = "r_rules"` .


## Examples

```r
library(shiny)
library(qbr)

filters <- list(
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

ui <- fluidPage(
queryBuilderInput(
inputId = "r_filter",
filters = filters,
return_value = "r_rules"
),
tableOutput("cars")
)

server <- function(input, output) {
output$cars <- renderTable({
filter_table(mtcars, input$r_filter)
})
}


if (interactive) {
shinyApp(ui, server)
}
```


