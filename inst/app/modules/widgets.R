widget_filters <- list(
  list(
    id = "date",
    label = "Datepicker",
    type = "date",
    validation = list(
      format = "YYYY/MM/DD"
    ),
    plugin = "datepicker",
    plugin_config = list(
      format = "yyyy/mm/dd",
      todayBtn = "linked",
      todayHighlight = TRUE,
      autoclose = TRUE
    )
  ),
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
  ),
  list(
    id = "state",
    label = "State",
    type = "string",
    input = "select",
    multiple = TRUE,
    plugin = "selectize",
    plugin_config = list(
      valueField = "id",
      labelField = "name",
      searchField = "name",
      sortField = "name",
      options = list(
        list(id = "AL", name = "Alabama"),
        list(id = "AK", name = "Alaska"),
        list(id = "AZ", name = "Arizona"),
        list(id = "AR", name = "Arkansas"),
        list(id = "CA", name = "California"),
        list(id = "CO", name = "Colorado"),
        list(id = "CT", name = "Connecticut"),
        list(id = "DE", name = "Delaware"),
        list(id = "DC", name = "District of Columbia"),
        list(id = "FL", name = "Florida"),
        list(id = "GA", name = "Georgia"),
        list(id = "HI", name = "Hawaii"),
        list(id = "ID", name = "Idaho")
      )
    )
  )
)


rules_widgets <- list(
  condition = "OR",
  rules = list(
    list(
      id = "date",
      operator = "equal",
      value = "1991/11/17"
    ),
    list(
      id = "rate",
      operator = "equal",
      value = 22
    ),
    list(
      id = "state",
      operator = "equal",
      value = "AL"
    )
  )
)



widget_builder_ui <- function(id) {
  ns <- NS(id)
  tagList(
    tags$head(
      tags$script(
        sprintf(
          "
    $( document ).ready(function() {
    $('#%s').on('afterCreateRuleInput.queryBuilder', function(e, rule) {
  if (rule.filter.plugin == 'selectize') {
    rule.$el.find('.rule-value-container').css('min-width', '200px')
      .find('.selectize-control').removeClass('form-select');
      rule.$el.find('.rule-value-container').find('.selectize-dropdown').removeClass('form-select');
  }});
});",
          ns("widgets")
        )
      )
    ),
    fluidRow(
      column(
        width = 8,
        h2("Widgets"),
        p("jqbr supports all three available widgets for queryBuilder: 'datepicker',
                'slider' and 'selectize'. See them in action below.")
      )
    ),
    fluidRow(
      column(
        width = 6,
        h4("Builder"),
        queryBuilderInput(
          inputId = ns("widgets"),
          filters = widget_filters,
          rules = rules_widgets,
          display_errors = TRUE,
          return_value = "all"
        ),
        fluidRow(
          column(
            width = 12,
            div(
              style = "display: inline-block;",
              actionButton(
                ns("reset"),
                "Reset",
                class = "btn-danger"
              ),
              actionButton(
                ns("set_rules"),
                "Set rules",
                class = "btn-warning"
              )
            )
          )
        )
      ),
      column(
        width = 6,
        h4("Outputs"),
        rule_output_ui(ns("widget_output"))
      )
    )
  )
}


widget_builder_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    rule_output <- reactive(input$widgets)
    rule_output_server("widget_output", rule_output)


    observeEvent(input$reset, {
      updateQueryBuilder(
        inputId = "widgets",
        reset = TRUE
      )
    })

    observeEvent(input$set_rules, {
      updateQueryBuilder(
        inputId = "widgets",
        setRules = rules_widgets
      )
    })
  })
}