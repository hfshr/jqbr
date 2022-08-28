# `updateQueryBuilder`

updateQueryBuilder


## Description

Update a queryBuilder with available methods.


## Usage

```r
updateQueryBuilder(
  inputId,
  setFilters = NULL,
  addFilter = NULL,
  setRules = NULL,
  destroy = FALSE,
  reset = FALSE,
  session = shiny::getDefaultReactiveDomain()
)
```


## Arguments

Argument      |Description
------------- |----------------
`inputId`     |     inputId of builder to update.
`setFilters`     |     list of lists container new filters.
`addFilter`     |     Named list containing `filter` and `position` elements. `filter` should be a list contianing a list which has the new filter to add. `position` can be a string of either "start" or "end" or a integer specifying the position to insert the rule. If position if ommited, filter will be inserted at the end.
`setRules`     |     List of rules apply to the builder.
`destroy`     |     bool. `TRUE` to destory filter.
`reset`     |     bool. `TRUE` to reset filter.
`session`     |     The session object passed to function given to shinyServer. Default is getDefaultReactiveDomain().


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


