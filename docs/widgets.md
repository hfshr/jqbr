# Widgets

There are also three widgets that can be included, see them in action [here](https://querybuilder.js.org/demo.html#widgets). These are similar to plugins, but need to be specified in the filter as opposed to the plugin list.

The possible options for the plugin value in each filter are one of "slider", "datepicker" or "selectize". For example, to include the slider widget you could include the following in your list of filters.

```r

filters <- list(
  list(
    id = "rate",
    label = "Slider",
    type = "integer",
    validation = list(
      min = 0,
      max = 100
    ),
    plugin = "slider",
    plugin_config = list(
      min = 0,
      max = 100,
      value = 0
    )
  )
)

```
