library(shiny)

description <-
  "function(rule) {
    if (rule.operator && ['in', 'not_in'].indexOf(rule.operator.type) !== -1) {
      return 'Use a pipe (|) to separate multiple values with in and not in operators';}}"

# description <- "function(rule) {
#         return 'The description for ' + (rule.operator ? rule.operator.type : 'anything');}"

# class(description) <- "json"

filters <- list(
  list(
    id = "name",
    label = "Name",
    type = "string",
    description = description
  ),
  list(
    id = "category",
    label = "Category",
    type = "integer",
    input = "checkbox",
    values = list(
      "Books",
      "Movies",
      "Music",
      "Tools",
      "Goodies",
      "Clothes"
    ),
    operators = c(
      "equal",
      "not_equal",
      "in",
      "not_in",
      "is_null",
      "is_not_null"
    )
  ),
  list(
    id = "coord",
    label = "Coordinates",
    type = "string",
    input = "function(rule, name) {
      var $container = rule.$el.find('.rule-value-container');

      $container.on('change', '[name='+ name +'_1]', function(){
        var h = '';

        switch ($(this).val()) {
          case 'A':
            h = '<option value=\"-1\">-</option> <option value=\"1\">1</option> <option value=\"2\">2</option>';
            break;
          case 'B':
            h = '<option value=\"-1\">-</option> <option value=\"3\">3</option> <option value=\"4\">4</option>';
            break;
          case 'C':
            h = '<option value=\"-1\">-</option> <option value=\"5\">5</option> <option value=\"6\">6</option>';
            break;
        }

        $container.find('[name$=_2]')
          .html(h).toggle(!!h)
          .val('-1').trigger('change');
      });

      return '\\
      <select name=\"'+ name +'_1\"> \\
        <option value=\"-1\">-</option> \\
        <option value=\"A\">A</option> \\
        <option value=\"B\">B</option> \\
        <option value=\"C\">C</option> \\
      </select> \\
      <select name=\"'+ name +'_2\" style=\"display:none;\"></select>';
    }",
    valueGetter = "function(rule) {
      return rule.$el.find('.rule-value-container [name$=_1]').val()
        +'.'+ rule.$el.find('.rule-value-container [name$=_2]').val();
    }",
    valueSetter = "function(rule, value) {
      if (rule.operator.nb_inputs > 0) {
        var val = value.split('.');

        rule.$el.find('.rule-value-container [name$=_1]').val(val[0]).trigger('change');
        rule.$el.find('.rule-value-container [name$=_2]').val(val[1]).trigger('change');
      }
    }"
  )
)



rules <- list(
  rules = list(
    list(
      id = "name",
      operator = "equal",
      value = "hello"
    )
  )
)

plugins <- list(
  # "sortable" = NULL
  "filter-description" = list("mode" = "bootbox")
  # "bt-checkbox" = NULL,
  # "invert" = NULL
)
options(
  shiny.launch.browser = function(...) .vsc.browser(..., viewer = FALSE),
  shiny.port = httpuv::randomPort()
)

ui <- fluidPage(
  theme = bslib::bs_theme(version = 5),
  useQueryBuilder(bs_version = 5),
  fluidRow(
    column(
      width = 6,
      queryBuilderInput("qb",
        filters = filters,
        rules = rules,
        plugins = plugins
      )
    ),
    column(
      width = 4,
      actionButton("update", "Update")
    )
  )
)

server <- function(input, output, session) {
  observe({
    print(input$qb)
  })

  new_rules <- list(
    list(
      id = "go",
      type = "string"
    )
  )

  observe({
    updateQueryBuilder(
      inputId = "qb",
      setFilters = new_rules
    )
  }) |>
    bindEvent(input$update)

  session$onSessionEnded(function() {
    shiny::stopApp()
  })
}

shinyApp(ui = ui, server = server)
