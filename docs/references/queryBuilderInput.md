# `queryBuilderInput`

queryBuilderInput

## Description

Shiny input for queryBuilder.

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
  return_value = c("r_rules", "rules", "sql", "all"),
  output_options = NULL
)
```

## Arguments

| Argument             | Description                                                                                                                                                  |
| -------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------ | -------------------------------------------------------------------- |
| `filters`            | list of list specifying the available filters in the builder. See example for a See https://querybuilder.js.org/#filters for details on the possible options |
| `plugins`            | list of optional plugins.                                                                                                                                    |
| `rules`              | Initial set of rules. By default the builder will contain one empty rule                                                                                     |
| `optgroups`          | List of groups in the filters and operators dropdowns.                                                                                                       |
| `default_filter`     | string. The `id` of the default filter for any new rule.                                                                                                     |
| `sort_filters`       | boolean                                                                                                                                                      | function. Sort filters alphabetically, or with a custom JS function. |
| `allow_groups`       | boolean                                                                                                                                                      | int. Number of allowed nested groups. `TRUE` for no limit.           |
| `allow_empty`        | bool. If `TRUE` , no error will be thrown if the builder is entirely empty.                                                                                  |
| `display_errors`     | bool. If `TRUE` , when an error occurs on a rule, display an icon with a tooltip explaining the error.                                                       |
| `conditions`         | string. Array of available group conditions. Use the `lang` option to change the label.                                                                      |
| `select_placeholder` | string. Label of the "no filter" option.                                                                                                                     |
| `lang`               | Additional/overwrites translation strings.                                                                                                                   |

## Examples

```r
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
