#' Reset a queryBuilder widget
#'
#' This function is a simple wrapper around a `shiny::actionButton`
#' with an `onclick` attribute that will reset a queryBuilder widget.
#' Inputs are the same as a regular `actionbutton` with an additional
#' `queryBuilderId` input that should correspond to the id of the
#' queryBuilder widget you want to reset
#'
#' @param queryBuilderId string. Id of the queryBuilder widget you want to reset
#'
#'
#' @importFrom shiny actionButton
#'
#'
#' @export
resetQueryBuilder <- function(inputId,
                              label = NULL,
                              icon = NULL,
                              width = NULL,
                              queryBuilderId = NULL,
                              ...) {
  if (is.null(queryBuilderId)) {
    rlang::abort("Must supply a valid queryBuilderId")
  }

  actionButton(
    inputId = inputId,
    label = label,
    icon = icon,
    width = width,
    onclick = paste0("$('#", queryBuilderId, "').queryBuilder('reset');"),
    ...
  )
}


#TODO
destroyQueryBuilder <- function() {

}


updateFilters <- function() {


}




