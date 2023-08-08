.onLoad <- function(...) {
  shiny::addResourcePath("jqbr", system.file("packer", package = "jqbr"))
  shiny::registerInputHandler("jqbr.r_rules", function(data, ...) {
    if (is.null(data)) {
      NULL
    } else {
      recurse_filter(data[["rules"]])
    }
  }, force = TRUE)
  shiny::registerInputHandler("jqbr.rules", function(data, ...) {
    if (is.null(data)) {
      NULL
    } else {
      data[["rules"]]
    }
  }, force = TRUE)
  shiny::registerInputHandler("jqbr.sql_rules", function(data, ...) {
    if (is.null(data)) {
      NULL
    } else {
      data[["sql_rules"]]
    }
  }, force = TRUE)
  shiny::registerInputHandler("jqbr.all", function(data, ...) {
    if (is.null(data)) {
      NULL
    } else {
      list(
        r_rules = recurse_filter(data[["rules"]]),
        sql_rules = data[["sql_rules"]],
        rules = data[["rules"]]
      )
    }
  }, force = TRUE)
}
