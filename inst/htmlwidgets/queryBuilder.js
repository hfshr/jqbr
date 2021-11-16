HTMLWidgets.widget({

  name: 'queryBuilder',

  type: 'output',

  factory: function(el, width, height) {

    return {

      renderValue: function(x) {

          $(el).queryBuilder({
            filters: x.filters,
            plugins: x.plugins,
            rules: x.rules,
            display_errors:  x.display_errors,
            optgroups: x.optgroups,
            default_filter: x.default_filter,
            default_condition: x.default_condition,
            sort_filters: x.sort_filters,
            allow_empty: x.allow_empty,
            allow_groups: x.allow_groups,
            conditions: x.conditions,
            select_placeholder: x.select_placeholder,
            lang: x.lang
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
