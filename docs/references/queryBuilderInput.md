# `queryBuilderInput`

queryBuilderInput


## Description

Shiny input bindings for queryBuilder.


## Usage

```r
queryBuilderInput(
  inputId,
  width = "100%",
  filters,
  plugins = NULL,
  rules = NULL,
  optgroups = NULL,
  default_filter = NULL,
  sort_filters = FALSE,
  allow_groups = TRUE,
  allow_empty = FALSE,
  display_errors = FALSE,
  conditions = c("AND", "OR"),
  default_condition = "AND",
  inputs_separator = ",",
  display_empty_filter = TRUE,
  select_placeholder = "------",
  operators = NULL,
  return_value = c("r_rules", "rules", "sql", "all")
)
```


## Arguments

Argument      |Description
------------- |----------------
`inputId`     |     string. Input id for the builder.
`width`     |     Width of the builder. Default if "100%".
`filters`     |     list of list specifying the available filters in the builder. See example for a See https://querybuilder.js.org/#filters for details on the possible options
`plugins`     |     list of optional plugins.
`rules`     |     Initial set of rules. By default the builder will contain one empty rule
`optgroups`     |     List of groups in the filters and operators dropdowns.
`default_filter`     |     string. The `id` of the default filter for any new rule.
`sort_filters`     |     boolean \| string. Sort filters alphabetically, or with a custom JS function.
`allow_groups`     |     boolean \| integer. Number of allowed nested groups. `TRUE` for no limit.
`allow_empty`     |     boolean. If `TRUE` , no error will be thrown if the builder is entirely empty.
`display_errors`     |     boolean. If `TRUE` , when an error occurs on a rule, display an icon with a tooltip explaining the error.
`conditions`     |     string. Array of available group conditions. Use the `lang` option to change the label.
`default_condition`     |     Default active condition. Default 'AND'.
`inputs_separator`     |     string used to separate multiple inputs (for between operator). default is ",".
`display_empty_filter`     |     boolean. Default `TRUE` . Add an empty option with `select_placeholder` string to the filter dropdowns. If the empty filter is disabled and no `default_filter`  is defined, the first filter will be loaded when adding a rule.
`select_placeholder`     |     string. Label of the "no filter" option.
`operators`     |     NULL or list. If a list, format should follow that described here: https://querybuilder.js.org/#operators
`return_value`     |     string. On of `"r_rules"` , `"rules"` , `"sql_rules"`  or `"all"` . Default "r_rules". Determines the return value from the builder accessed with input$<builder_id> in shiny server
`add_na_filter`      |     bool. If `TRUE`, `"is_na"` and `"is_not_na"` are added to the global filter list for testing for NA values. Only works when `return_type` is "rules" or "r_rules".


## Examples

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
        type = "string"
      )
    )
  )
)

server <- function(input, output) {
  observeEvent(input$qb, {
    print(input$qb)
  })
}

# Add is_na filter

ui <- fluidPage(
  useQueryBuilder(),
  queryBuilderInput(
    inputId = "qb",
    add_na_filter = TRUE,
    return_value = "r_rules",
    filters = list(
      list(
        id = "name",
        type = "string"
      )
    )
  )
)

server <- function(input, output) {
  observeEvent(input$qb, {
    print(input$qb)
  })
}

if (interactive()) {
  shinyApp(ui, server)
}
```


