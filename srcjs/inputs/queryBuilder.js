import $ from "jquery";
import "shiny";

const _escapeHtml = (unsafe) => {
  return unsafe
    .replaceAll("&amp;", "&")
    .replaceAll("&lt;", "<")
    .replaceAll("&gt;", ">");
};

var queryBuilderBinding = new Shiny.InputBinding();

$.extend(queryBuilderBinding, {
  find: (scope) => {
    return $(scope).find(".queryBuilderBinding");
  },
  initialize: (el) => {
    // var options = $(el).data("options");
    var element = document.getElementById(el.id);
    var options = element.querySelector('script[data-for="' + el.id + '"]');
    var parsedOptions = JSON.parse(options.innerHTML, function (key, value) {
      // ugly hack to parse strings that are functions :(
      if (typeof value === "string" && value.startsWith("function(")) {
        value = _escapeHtml(value);
        // console.log(value);
        return (0, eval)("(" + value + ")");
      }
      return value;
    });

    $("#" + el.id).queryBuilder(parsedOptions);
  },
  getValue: (el) => {
    var rules = $("#" + el.id).queryBuilder("getRules");
    var sql_rules = $("#" + el.id).queryBuilder("getSQL");
    return { rules: rules, sql_rules: sql_rules };
  },
  setValue: (el, value) => {
    // Remove all filters and replace with new ones
    console.log(value.setFilters, value.setRules, value.destory, value.reset);
    if (value.setFilters != null) {
      $("#" + el.id).queryBuilder("setFilters", true, value.setFilters);
    }
    // Update queryBuilder with a set of rules
    if (value.setRules != null) {
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
