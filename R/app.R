#' @export
run_qbr_demo <- function() {
  appDir <- system.file("app", package = "qbr")
  if (appDir == "") {
    stop("Could not find example directory. Try re-installing `mypackage`.", call. = FALSE)
  }

  shiny::runApp(appDir, display.mode = "normal")
}