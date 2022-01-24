# Helper function to find plugins that require extra dependencies
find_plugins <- function(plugins) {
    named_plugins <- names(plugins)
    if ("filter-description" %in% named_plugins) {
        if (plugins[["filter-description"]][["mode"]] == "bootbox") {
            named_plugins <- c(named_plugins, "bootbox")
        }
    }
    named_plugins
}

# Add required plugins
plugin_deps <- function(plugins) {
    all_deps <- shiny::tagList()

    if ("sortable" %in% plugins) {
        sortable <- htmltools::htmlDependency(
            name = "interactjs",
            version = "1.10.11",
            src = c(href = "https://cdnjs.cloudflare.com/ajax/libs/interact.js/1.10.11/"),
            script = "interact.min.js"
        )
        all_deps <- shiny::tagList(
            all_deps,
            sortable
        )
    }

    if ("bootbox" %in% plugins) {
        bootbox <- htmltools::htmlDependency(
            name = "bootbox",
            version = "5.5.2",
            src = c(href = "https://cdnjs.cloudflare.com/ajax/libs/bootbox.js/5.5.2/"),
            script = "bootbox.min.js"
        )
        all_deps <- shiny::tagList(
            all_deps,
            bootbox
        )
    }

    if ("bt-selectpicker" %in% plugins) {
        bs_select <- htmltools::htmlDependency(
            name = "bt-selectpicker",
            version = "1.13.18",
            src = c(href = "https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.13.18/js/"),
            script = "bootstrap-select.min.js"
        )
        all_deps <- shiny::tagList(
            all_deps,
            bs_select
        )
    }

    if ("chosen-selectpicker" %in% plugins) {
        chosen <- htmltools::htmlDependency(
            name = "chosen-selectpicker",
            version = "1.8.7",
            src = c(href = "https://cdnjs.cloudflare.com/ajax/libs/chosen/1.8.7/"),
            script = "chosen.jquery.min.js"
        )
        all_deps <- shiny::tagList(
            all_deps,
            chosen
        )
    }

    if ("bt-checkbox" %in% plugins) {
        bt_checkbox <- htmltools::htmlDependency(
            name = "bt-checkbox",
            version = "1.0.2",
            src = c(href = "https://cdnjs.cloudflare.com/ajax/libs/awesome-bootstrap-checkbox/1.0.2/"),
            stylesheet = "awesome-bootstrap-checkbox.min.css"
        )
        all_deps <- shiny::tagList(
            all_deps,
            bt_checkbox
        )
    }
}
