#' run_jqbr_demo
#'
#' Run the jqbr demo app
#'
#' @return A Shiny app
#'
#' @examples
#'
#' if (interactive()) {
#'   run_jqbr_demo()
#' }
#' @export
run_jqbr_demo <- function() {
  appDir <- system.file("app", package = "jqbr")
  if (appDir == "") {
    stop("Could not find example directory. Try re-installing `jqbr`.", call. = FALSE)
  }

  shiny::runApp(appDir, display.mode = "normal")
}