HTMLWidgets.widget({

  name: 'queryBuilder',

  type: 'output',

  factory: function(el, width, height) {

    // TODO: define shared variables for this instance

    return {

      renderValue: function(x) {

        $(el).queryBuilder({

          plugins: x.plugins,
          filters: x.filters,
          rules: x.rules,
          display_errors:  x.display_errors,
          allow_empty: x.allow_empty
        });

          $(el).on('afterMove.queryBuilder afterSetRules.queryBuilder afterCreateRuleInput.queryBuidler afterInit.queryBuilder afterDeleteGroup.queryBuilder afterDeleteRule.queryBuilder afterUpdateRuleValue.queryBuilder afterUpdateRuleFilter.queryBuilder afterUpdateRuleOperator.queryBuilder  afterUpdateGroupCondition.queryBuilder', function(e, rule, error, value) {
                  Shiny.onInputChange(el.id + '_out', $(el).queryBuilder('getRules'));
                  Shiny.onInputChange(el.id + '_validate', $(el).queryBuilder('validate'));
                  Shiny.onInputChange(el.id + '_sql', $(el).queryBuilder('getSQL', false));
        });



      },

      resize: function(width, height) {

        // TODO: code to re-render the widget with a new size

      }

    };
  }
});
