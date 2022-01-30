# Advanced

It is possible to use custom javascript function to further enhance the builder.

Custom description when "in" or "not in" operator is used.

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

plugins <- list(
  "filter-description" = list("mode" = "inline")
)



```
