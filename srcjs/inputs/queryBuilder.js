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
  getType: function (el) {
    let return_type = $(el).attr("data-return");
    if (return_type === "r_rules") {
      return "jqbr.r_rules";
    }
    if (return_type === "rules") {
      return "jqbr.rules";
    }
    if (return_type === "sql") {
      return "jqbr.sql_rules";
    }
    if (return_type === "all") {
      return "jqbr.all";
    }
  },
  initialize: (el) => {
    var element = document.getElementById(el.id);
    var options = element.querySelector('script[data-for="' + el.id + '"]');
    var parsedOptions = JSON.parse(options.innerHTML, function (key, value) {
      // ugly hack to parse strings that are functions :(
      if (typeof value === "string" && value.startsWith("function(")) {
        //console.log(value);
        value = _escapeHtml(value);
        //console.log(value);
        return (0, eval)("(" + value + ")");
      }
      return value;
    });

    $("#" + el.id).queryBuilder(parsedOptions);
  },
  getValue: (el) => {
    let return_type = $(el).attr("data-return");

    var rules = $("#" + el.id).queryBuilder("getRules");
    var valid = $("#" + el.id).queryBuilder("validate");

    Shiny.setInputValue(el.id + "_valid", valid);

    if (return_type === "r_rules" || return_type === "rules") {
      return { rules: rules };
    } else if (return_type === "sql_rules" || return_type === "all") {
      var sql_rules = $("#" + el.id).queryBuilder("getSQL");

      return { rules: rules, sql_rules: sql_rules };
    }
  },
  setValue: (el, value) => {
    // Remove all filters and replace with new ones
    if (value.setFilters != null) {
      $("#" + el.id).queryBuilder("setFilters", true, value.setFilters);
    }
    if (value.addFilter != null) {
      if (value.addFilter.position == null) {
        value.addFilter.position = "end";
      }
      $("#" + el.id).queryBuilder(
        "addFilter",
        value.addFilter.filter,
        value.addFilter.position
      );
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
    this.setValue(el, data);
    // other parameters to update...
  },
});

Shiny.inputBindings.register(queryBuilderBinding, "jqbr.queryBuilderBinding");
