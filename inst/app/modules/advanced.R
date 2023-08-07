
advanced_filters <- list(
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


rules_advanced <- list(
  condition = "AND",
  rules = list(
    list(
      id = "coord",
      operator = "equal",
      value = "B.3"
    )
  )
)



advanced_builder_ui <- function(id) {
  ns <- NS(id)
  tagList(
    fluidRow(
      column(
        width = 12,
        h2("Advanced"),
        p(
          "jqbr supports javascript functions to define custom inputs.",
          "Just pass the js function as a string and jqbr will handle the rest!",
          "Based on the example ", tags$a(
            href = "https://querybuilder.js.org/demo.html#widgets",
            "here."
          )
        )
      )
    ),
    fluidRow(
      column(
        width = 6,
        h4("Builder"),
        queryBuilderInput(
          inputId = ns("advanced"),
          filters = advanced_filters,
          rules = rules_advanced,
          return_value = "all"
        )
      ),
      column(
        width = 6,
        h4("Output"),
        rule_output_ui(ns("plugin_output"))
      )
    )
  )
}

advanced_builder_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    rule_output <- reactive(input$advanced)
    rule_output_server("plugin_output", rule_output)
  })
}