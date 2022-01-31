# `updateQueryBuilder`

updateQueryBuilder


## Description

Update a queryBuilder with available methods.


## Usage

```r
updateQueryBuilder(
  inputId,
  setFilters = NULL,
  addFilters = NULL,
  setRules = NULL,
  destroy = FALSE,
  reset = FALSE,
  session = getDefaultReactiveDomain()
)
```


## Arguments

Argument      |Description
------------- |----------------
`inputId`     |     inputId of builder to update.
`setFilters`     |     list of lists container new filters.
`addFilters`     |     list of lists containing filters to add.
`setRules`     |     List of rules apply to the builder.
`destroy`     |     bool. `TRUE` to destory filter.
`reset`     |     bool. `TRUE` to reset filter.


## Examples

```r
library(shiny)
library(qbr)

# Button to reset the build an remove all rules
ui <- fluidPage(
queryBuilderInput(
inputId = "qb",
filters = list(
list(
id = "name",
type = "string"
)
)
),
actionButton("reset", "Reset")
)

server <- function(input, output) {
observeEvent(input$reset, {
updateQueryBuilder(
inputId = "qb",
reset = TRUE
)
})
}

if (interactive()) {
shinyApp(ui, server)
}
```


