import $ from "jquery";
import "shiny";

var queryBuilderBinding = new Shiny.InputBinding();

$.extend(queryBuilderBinding, {
  find: (scope) => {
    return $(scope).find(".queryBuilderBinding");
  },
  initialize: (el) => {
    // var options = $(el).data("options");
    var element = document.getElementById(el.id);
    var options = element.querySelector('script[data-for="' + el.id + '"]');
    options = JSON.parse(options.innerHTML);

    // function Iterate(data) {
    //   jQuery.each(data, function (index, value) {
    //     if (typeof value == "object") {
    //       Iterate(value);
    //     } else {
    //       if (value.indexOf("function(rule)") > -1)
    //         data[index] = eval("(" + value + ")");
    //     }
    //   });
    // }

    // Iterate(options.filters);

    $("#" + el.id).queryBuilder(options);
  },
  getValue: (el) => {
    var rules = $("#" + el.id).queryBuilder("getRules");
    var sql_rules = $("#" + el.id).queryBuilder("getSQL");
    // return { rules: rules, sql_rules: sql_rules };
    return rules;
  },
  setValue: (el, value) => {
    // Remove all filters and replace with new ones
    if (value.setFilters !== null) {
      $("#" + el.id).queryBuilder("setFilters", true, value.setFilters);
    }
    // Update queryBuilder with a set of rules
    if (value.setRules !== null) {
      $("#" + el.id).queryBuilder("setRules", value.setRules);
    }
    // destory queryBuilder
    if (value.destory) {
      $("#" + el.id).queryBuilder("destory");
    }
    // reset queryBuilder
    if (value.reset) {
      $("#" + el.id).queryBuilder("reset");
    }
  },
  subscribe: (el, callback) => {
    $(el).on(
      `
     afterMove.queryBuilder 
     afterSetRules.queryBuilder 
     afterCreateRuleInput.queryBuidler 
     afterInit.queryBuilder 
     afterDeleteGroup.queryBuilder 
     afterDeleteRule.queryBuilder
     afterUpdateRuleValue.queryBuilder 
     afterUpdateRuleFilter.queryBuilder 
     afterUpdateRuleOperator.queryBuilder  
     afterUpdateGroupCondition.queryBuilder
     `,
      function (e) {
        callback();
      }
    );
  },
  unsubscribe: (el) => {
    $(el).off(".queryBuilderBinding");
  },
  receiveMessage: function (el, data) {
    // console.log(data);
    this.setValue(el, data);
    // other parameters to update...
  },
});

Shiny.inputBindings.register(queryBuilderBinding, "qbr.queryBuilderBinding");
