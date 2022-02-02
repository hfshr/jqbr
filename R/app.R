#' run_qbr_demo
#'
#' Run the qbr demo app
#'
#' @examples
#'
#' if (interactive()) {
#'   run_qbr_demo()
#' }
#' @export
run_qbr_demo <- function() {
  appDir <- system.file("app", package = "qbr")
  if (appDir == "") {
    stop("Could not find example directory. Try re-installing `mypackage`.", call. = FALSE)
  }

  shiny::runApp(appDir, display.mode = "normal")
}
