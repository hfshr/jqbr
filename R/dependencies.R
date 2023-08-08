#' Find plugins
#' Find plugins from list
#' @param plugins list of plugins
#' @noRd
find_plugins <- function(plugins) {
  named_plugins <- names(plugins)
  if ("filter-description" %in% named_plugins) {
    if (plugins[["filter-description"]][["mode"]] == "bootbox") {
      named_plugins <- c(named_plugins, "bootbox")
    }
  }
  named_plugins
}

#' Plugins
#' @param plugins character vector of required plugins
#' @noRd
plugin_deps <- function(plugins) {
  all_deps <- htmltools::tagList()

  if ("sortable" %in% plugins) {
    sortable <- htmltools::htmlDependency(
      name = "interactjs",
      version = "1.10.11",
      src = c(href = "https://cdnjs.cloudflare.com/ajax/libs/interact.js/1.10.11/"),
      script = "interact.min.js"
    )
    all_deps <- htmltools::tagList(
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
    all_deps <- htmltools::tagList(
      all_deps,
      bootbox
    )
  }

  if ("bt-selectpicker" %in% plugins) {
    bs_select <- htmltools::htmlDependency(
      name = "bt-selectpicker",
      version = "1.13.18",
      src = c(href = "https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.14.0-beta2/js/"),
      script = "bootstrap-select.min.js"
    )
    all_deps <- htmltools::tagList(
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
    all_deps <- htmltools::tagList(
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
    all_deps <- htmltools::tagList(
      all_deps,
      bt_checkbox
    )
  }

  all_deps
}

#' Widget deps
#' Find widgets dependencies in list of filters
#' @param filters list of filters
#' @noRd
widget_deps <- function(filters) {
  widget_dep_names <- unlist(
    drop_nulls(
      lapply(filters, `[[`, "plugin")
    )
  )

  all_deps <- htmltools::tagList()

  if ("slider" %in% widget_dep_names) {
    slider <- htmltools::htmlDependency(
      name = "bootstrap-slider",
      version = "11.0.2",
      src = c(href = "https://cdnjs.cloudflare.com/ajax/libs/bootstrap-slider/11.0.2/"),
      script = "bootstrap-slider.min.js",
      stylesheet = "css/bootstrap-slider.min.css"
    )
    all_deps <- htmltools::tagList(
      all_deps,
      slider
    )
  }

  if ("datepicker" %in% widget_dep_names) {
    datepicker <- htmltools::htmlDependency(
      name = "datepicker",
      version = "1.9.0",
      src = c(href = "https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/"),
      script = "js/bootstrap-datepicker.min.js",
      stylesheet = "css/bootstrap-datepicker.standalone.min.css"
    )
    # For datetime validation
    moment <- htmltools::htmlDependency(
      name = "moment",
      version = "2.29.1",
      src = c(href = "https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/"),
      script = "moment.min.js"
    )

    all_deps <- htmltools::tagList(
      all_deps,
      datepicker,
      moment
    )
  }

  if ("selectize" %in% widget_dep_names) {
    selectize <- htmltools::htmlDependency(
      name = "selectize",
      version = "0.13.3",
      src = c(href = "https://cdnjs.cloudflare.com/ajax/libs/selectize.js/0.13.3/"),
      script = "js/standalone/selectize.min.js",
      stylesheet = "css/selectize.default.min.css"
    )
    all_deps <- htmltools::tagList(
      all_deps,
      selectize
    )
  }

  all_deps
}
