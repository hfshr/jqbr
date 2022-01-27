.onLoad <- function(...) {
    shiny::addResourcePath("qbr", system.file("packer", package = "qbr"))
    shiny::registerInputHandler("qbr.r_rules", function(data, ...) {
        if (is.null(data)) {
            NULL
        } else {
            recurseFilter(data[["rules"]])
        }
    }, force = TRUE)
    shiny::registerInputHandler("qbr.rules", function(data, ...) {
        if (is.null(data)) {
            NULL
        } else {
            data[["rules"]]
        }
    }, force = TRUE)
    shiny::registerInputHandler("qbr.sql_rules", function(data, ...) {
        if (is.null(data)) {
            NULL
        } else {
            data[["sql_rules"]]
        }
    }, force = TRUE)
    shiny::registerInputHandler("qbr.all", function(data, ...) {
        if (is.null(data)) {
            NULL
        } else {
            list(
                r_rules = recurseFilter(data[["rules"]]),
                sql_rules = data[["sql_rules"]],
                rules = data[["rules"]]
            )
        }
    }, force = TRUE)
}
