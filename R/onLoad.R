.onLoad <- function(...) {
    shiny::addResourcePath("qbr", system.file("packer", package = "qbr"))
    shiny::registerInputHandler("qbr.queryBuilderBinding", function(data, ...) {
        if (is.null(data) || length(data) < 1) {
            "donkey"
        } else {
            data
        }
    }, force = TRUE)
}
