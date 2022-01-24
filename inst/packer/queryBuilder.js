/******/ (() => { // webpackBootstrap
/******/ 	"use strict";
/******/ 	var __webpack_modules__ = ({

/***/ "shiny":
/*!************************!*\
  !*** external "Shiny" ***!
  \************************/
/***/ ((module) => {

module.exports = Shiny;

/***/ }),

/***/ "jquery":
/*!*************************!*\
  !*** external "jQuery" ***!
  \*************************/
/***/ ((module) => {

module.exports = jQuery;

/***/ })

/******/ 	});
/************************************************************************/
/******/ 	// The module cache
/******/ 	var __webpack_module_cache__ = {};
/******/ 	
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/ 		// Check if module is in cache
/******/ 		var cachedModule = __webpack_module_cache__[moduleId];
/******/ 		if (cachedModule !== undefined) {
/******/ 			return cachedModule.exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = __webpack_module_cache__[moduleId] = {
/******/ 			// no module.id needed
/******/ 			// no module.loaded needed
/******/ 			exports: {}
/******/ 		};
/******/ 	
/******/ 		// Execute the module function
/******/ 		__webpack_modules__[moduleId](module, module.exports, __webpack_require__);
/******/ 	
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/ 	
/************************************************************************/
/******/ 	/* webpack/runtime/compat get default export */
/******/ 	(() => {
/******/ 		// getDefaultExport function for compatibility with non-harmony modules
/******/ 		__webpack_require__.n = (module) => {
/******/ 			var getter = module && module.__esModule ?
/******/ 				() => (module['default']) :
/******/ 				() => (module);
/******/ 			__webpack_require__.d(getter, { a: getter });
/******/ 			return getter;
/******/ 		};
/******/ 	})();
/******/ 	
/******/ 	/* webpack/runtime/define property getters */
/******/ 	(() => {
/******/ 		// define getter functions for harmony exports
/******/ 		__webpack_require__.d = (exports, definition) => {
/******/ 			for(var key in definition) {
/******/ 				if(__webpack_require__.o(definition, key) && !__webpack_require__.o(exports, key)) {
/******/ 					Object.defineProperty(exports, key, { enumerable: true, get: definition[key] });
/******/ 				}
/******/ 			}
/******/ 		};
/******/ 	})();
/******/ 	
/******/ 	/* webpack/runtime/hasOwnProperty shorthand */
/******/ 	(() => {
/******/ 		__webpack_require__.o = (obj, prop) => (Object.prototype.hasOwnProperty.call(obj, prop))
/******/ 	})();
/******/ 	
/******/ 	/* webpack/runtime/make namespace object */
/******/ 	(() => {
/******/ 		// define __esModule on exports
/******/ 		__webpack_require__.r = (exports) => {
/******/ 			if(typeof Symbol !== 'undefined' && Symbol.toStringTag) {
/******/ 				Object.defineProperty(exports, Symbol.toStringTag, { value: 'Module' });
/******/ 			}
/******/ 			Object.defineProperty(exports, '__esModule', { value: true });
/******/ 		};
/******/ 	})();
/******/ 	
/************************************************************************/
var __webpack_exports__ = {};
// This entry need to be wrapped in an IIFE because it need to be isolated against other modules in the chunk.
(() => {
/*!**************************************!*\
  !*** ./srcjs/inputs/queryBuilder.js ***!
  \**************************************/
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var jquery__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! jquery */ "jquery");
/* harmony import */ var jquery__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(jquery__WEBPACK_IMPORTED_MODULE_0__);
/* harmony import */ var shiny__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! shiny */ "shiny");
/* harmony import */ var shiny__WEBPACK_IMPORTED_MODULE_1___default = /*#__PURE__*/__webpack_require__.n(shiny__WEBPACK_IMPORTED_MODULE_1__);



const _escapeHtml = (unsafe) => {
  return unsafe
    .replaceAll("&amp;", "&")
    .replaceAll("&lt;", "<")
    .replaceAll("&gt;", ">");
};

var queryBuilderBinding = new Shiny.InputBinding();

jquery__WEBPACK_IMPORTED_MODULE_0___default().extend(queryBuilderBinding, {
  find: (scope) => {
    return jquery__WEBPACK_IMPORTED_MODULE_0___default()(scope).find(".queryBuilderBinding");
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

    jquery__WEBPACK_IMPORTED_MODULE_0___default()("#" + el.id).queryBuilder(parsedOptions);
  },
  getValue: (el) => {
    var rules = jquery__WEBPACK_IMPORTED_MODULE_0___default()("#" + el.id).queryBuilder("getRules");
    var sql_rules = jquery__WEBPACK_IMPORTED_MODULE_0___default()("#" + el.id).queryBuilder("getSQL");
    return { rules: rules, sql_rules: sql_rules };
  },
  setValue: (el, value) => {
    // Remove all filters and replace with new ones
    console.log(value.setFilters, value.setRules, value.destory, value.reset);
    if (value.setFilters != null) {
      jquery__WEBPACK_IMPORTED_MODULE_0___default()("#" + el.id).queryBuilder("setFilters", true, value.setFilters);
    }
    // Update queryBuilder with a set of rules
    if (value.setRules != null) {
      jquery__WEBPACK_IMPORTED_MODULE_0___default()("#" + el.id).queryBuilder("setRules", value.setRules);
    }
    // destory queryBuilder
    if (value.destory) {
      jquery__WEBPACK_IMPORTED_MODULE_0___default()("#" + el.id).queryBuilder("destory");
    }
    // reset queryBuilder
    if (value.reset) {
      jquery__WEBPACK_IMPORTED_MODULE_0___default()("#" + el.id).queryBuilder("reset");
    }
  },
  subscribe: (el, callback) => {
    jquery__WEBPACK_IMPORTED_MODULE_0___default()(el).on(
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
    jquery__WEBPACK_IMPORTED_MODULE_0___default()(el).off(".queryBuilderBinding");
  },
  receiveMessage: function (el, data) {
    // console.log(data);
    this.setValue(el, data);
    // other parameters to update...
  },
});

Shiny.inputBindings.register(queryBuilderBinding, "qbr.queryBuilderBinding");

})();

/******/ })()
;
//# sourceMappingURL=data:application/json;charset=utf-8;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoicXVlcnlCdWlsZGVyLmpzIiwibWFwcGluZ3MiOiI7Ozs7Ozs7Ozs7QUFBQTs7Ozs7Ozs7OztBQ0FBOzs7Ozs7VUNBQTtVQUNBOztVQUVBO1VBQ0E7VUFDQTtVQUNBO1VBQ0E7VUFDQTtVQUNBO1VBQ0E7VUFDQTtVQUNBO1VBQ0E7VUFDQTtVQUNBOztVQUVBO1VBQ0E7O1VBRUE7VUFDQTtVQUNBOzs7OztXQ3RCQTtXQUNBO1dBQ0E7V0FDQTtXQUNBO1dBQ0EsaUNBQWlDLFdBQVc7V0FDNUM7V0FDQTs7Ozs7V0NQQTtXQUNBO1dBQ0E7V0FDQTtXQUNBLHlDQUF5Qyx3Q0FBd0M7V0FDakY7V0FDQTtXQUNBOzs7OztXQ1BBOzs7OztXQ0FBO1dBQ0E7V0FDQTtXQUNBLHVEQUF1RCxpQkFBaUI7V0FDeEU7V0FDQSxnREFBZ0QsYUFBYTtXQUM3RDs7Ozs7Ozs7Ozs7Ozs7O0FDTnVCO0FBQ1I7O0FBRWY7QUFDQTtBQUNBLHNCQUFzQjtBQUN0QixxQkFBcUI7QUFDckIscUJBQXFCO0FBQ3JCOztBQUVBOztBQUVBLG9EQUFRO0FBQ1I7QUFDQSxXQUFXLDZDQUFDO0FBQ1osR0FBRztBQUNIO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBLEtBQUs7O0FBRUwsSUFBSSw2Q0FBQztBQUNMLEdBQUc7QUFDSDtBQUNBLGdCQUFnQiw2Q0FBQztBQUNqQixvQkFBb0IsNkNBQUM7QUFDckIsYUFBYTtBQUNiLEdBQUc7QUFDSDtBQUNBO0FBQ0E7QUFDQTtBQUNBLE1BQU0sNkNBQUM7QUFDUDtBQUNBO0FBQ0E7QUFDQSxNQUFNLDZDQUFDO0FBQ1A7QUFDQTtBQUNBO0FBQ0EsTUFBTSw2Q0FBQztBQUNQO0FBQ0E7QUFDQTtBQUNBLE1BQU0sNkNBQUM7QUFDUDtBQUNBLEdBQUc7QUFDSDtBQUNBLElBQUksNkNBQUM7QUFDTDtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBLEdBQUc7QUFDSDtBQUNBLElBQUksNkNBQUM7QUFDTCxHQUFHO0FBQ0g7QUFDQTtBQUNBO0FBQ0E7QUFDQSxHQUFHO0FBQ0gsQ0FBQzs7QUFFRCIsInNvdXJjZXMiOlsid2VicGFjazovL3Fici9leHRlcm5hbCB2YXIgXCJTaGlueVwiIiwid2VicGFjazovL3Fici9leHRlcm5hbCB2YXIgXCJqUXVlcnlcIiIsIndlYnBhY2s6Ly9xYnIvd2VicGFjay9ib290c3RyYXAiLCJ3ZWJwYWNrOi8vcWJyL3dlYnBhY2svcnVudGltZS9jb21wYXQgZ2V0IGRlZmF1bHQgZXhwb3J0Iiwid2VicGFjazovL3Fici93ZWJwYWNrL3J1bnRpbWUvZGVmaW5lIHByb3BlcnR5IGdldHRlcnMiLCJ3ZWJwYWNrOi8vcWJyL3dlYnBhY2svcnVudGltZS9oYXNPd25Qcm9wZXJ0eSBzaG9ydGhhbmQiLCJ3ZWJwYWNrOi8vcWJyL3dlYnBhY2svcnVudGltZS9tYWtlIG5hbWVzcGFjZSBvYmplY3QiLCJ3ZWJwYWNrOi8vcWJyLy4vc3JjanMvaW5wdXRzL3F1ZXJ5QnVpbGRlci5qcyJdLCJzb3VyY2VzQ29udGVudCI6WyJtb2R1bGUuZXhwb3J0cyA9IFNoaW55OyIsIm1vZHVsZS5leHBvcnRzID0galF1ZXJ5OyIsIi8vIFRoZSBtb2R1bGUgY2FjaGVcbnZhciBfX3dlYnBhY2tfbW9kdWxlX2NhY2hlX18gPSB7fTtcblxuLy8gVGhlIHJlcXVpcmUgZnVuY3Rpb25cbmZ1bmN0aW9uIF9fd2VicGFja19yZXF1aXJlX18obW9kdWxlSWQpIHtcblx0Ly8gQ2hlY2sgaWYgbW9kdWxlIGlzIGluIGNhY2hlXG5cdHZhciBjYWNoZWRNb2R1bGUgPSBfX3dlYnBhY2tfbW9kdWxlX2NhY2hlX19bbW9kdWxlSWRdO1xuXHRpZiAoY2FjaGVkTW9kdWxlICE9PSB1bmRlZmluZWQpIHtcblx0XHRyZXR1cm4gY2FjaGVkTW9kdWxlLmV4cG9ydHM7XG5cdH1cblx0Ly8gQ3JlYXRlIGEgbmV3IG1vZHVsZSAoYW5kIHB1dCBpdCBpbnRvIHRoZSBjYWNoZSlcblx0dmFyIG1vZHVsZSA9IF9fd2VicGFja19tb2R1bGVfY2FjaGVfX1ttb2R1bGVJZF0gPSB7XG5cdFx0Ly8gbm8gbW9kdWxlLmlkIG5lZWRlZFxuXHRcdC8vIG5vIG1vZHVsZS5sb2FkZWQgbmVlZGVkXG5cdFx0ZXhwb3J0czoge31cblx0fTtcblxuXHQvLyBFeGVjdXRlIHRoZSBtb2R1bGUgZnVuY3Rpb25cblx0X193ZWJwYWNrX21vZHVsZXNfX1ttb2R1bGVJZF0obW9kdWxlLCBtb2R1bGUuZXhwb3J0cywgX193ZWJwYWNrX3JlcXVpcmVfXyk7XG5cblx0Ly8gUmV0dXJuIHRoZSBleHBvcnRzIG9mIHRoZSBtb2R1bGVcblx0cmV0dXJuIG1vZHVsZS5leHBvcnRzO1xufVxuXG4iLCIvLyBnZXREZWZhdWx0RXhwb3J0IGZ1bmN0aW9uIGZvciBjb21wYXRpYmlsaXR5IHdpdGggbm9uLWhhcm1vbnkgbW9kdWxlc1xuX193ZWJwYWNrX3JlcXVpcmVfXy5uID0gKG1vZHVsZSkgPT4ge1xuXHR2YXIgZ2V0dGVyID0gbW9kdWxlICYmIG1vZHVsZS5fX2VzTW9kdWxlID9cblx0XHQoKSA9PiAobW9kdWxlWydkZWZhdWx0J10pIDpcblx0XHQoKSA9PiAobW9kdWxlKTtcblx0X193ZWJwYWNrX3JlcXVpcmVfXy5kKGdldHRlciwgeyBhOiBnZXR0ZXIgfSk7XG5cdHJldHVybiBnZXR0ZXI7XG59OyIsIi8vIGRlZmluZSBnZXR0ZXIgZnVuY3Rpb25zIGZvciBoYXJtb255IGV4cG9ydHNcbl9fd2VicGFja19yZXF1aXJlX18uZCA9IChleHBvcnRzLCBkZWZpbml0aW9uKSA9PiB7XG5cdGZvcih2YXIga2V5IGluIGRlZmluaXRpb24pIHtcblx0XHRpZihfX3dlYnBhY2tfcmVxdWlyZV9fLm8oZGVmaW5pdGlvbiwga2V5KSAmJiAhX193ZWJwYWNrX3JlcXVpcmVfXy5vKGV4cG9ydHMsIGtleSkpIHtcblx0XHRcdE9iamVjdC5kZWZpbmVQcm9wZXJ0eShleHBvcnRzLCBrZXksIHsgZW51bWVyYWJsZTogdHJ1ZSwgZ2V0OiBkZWZpbml0aW9uW2tleV0gfSk7XG5cdFx0fVxuXHR9XG59OyIsIl9fd2VicGFja19yZXF1aXJlX18ubyA9IChvYmosIHByb3ApID0+IChPYmplY3QucHJvdG90eXBlLmhhc093blByb3BlcnR5LmNhbGwob2JqLCBwcm9wKSkiLCIvLyBkZWZpbmUgX19lc01vZHVsZSBvbiBleHBvcnRzXG5fX3dlYnBhY2tfcmVxdWlyZV9fLnIgPSAoZXhwb3J0cykgPT4ge1xuXHRpZih0eXBlb2YgU3ltYm9sICE9PSAndW5kZWZpbmVkJyAmJiBTeW1ib2wudG9TdHJpbmdUYWcpIHtcblx0XHRPYmplY3QuZGVmaW5lUHJvcGVydHkoZXhwb3J0cywgU3ltYm9sLnRvU3RyaW5nVGFnLCB7IHZhbHVlOiAnTW9kdWxlJyB9KTtcblx0fVxuXHRPYmplY3QuZGVmaW5lUHJvcGVydHkoZXhwb3J0cywgJ19fZXNNb2R1bGUnLCB7IHZhbHVlOiB0cnVlIH0pO1xufTsiLCJpbXBvcnQgJCBmcm9tIFwianF1ZXJ5XCI7XG5pbXBvcnQgXCJzaGlueVwiO1xuXG5jb25zdCBfZXNjYXBlSHRtbCA9ICh1bnNhZmUpID0+IHtcbiAgcmV0dXJuIHVuc2FmZVxuICAgIC5yZXBsYWNlQWxsKFwiJmFtcDtcIiwgXCImXCIpXG4gICAgLnJlcGxhY2VBbGwoXCImbHQ7XCIsIFwiPFwiKVxuICAgIC5yZXBsYWNlQWxsKFwiJmd0O1wiLCBcIj5cIik7XG59O1xuXG52YXIgcXVlcnlCdWlsZGVyQmluZGluZyA9IG5ldyBTaGlueS5JbnB1dEJpbmRpbmcoKTtcblxuJC5leHRlbmQocXVlcnlCdWlsZGVyQmluZGluZywge1xuICBmaW5kOiAoc2NvcGUpID0+IHtcbiAgICByZXR1cm4gJChzY29wZSkuZmluZChcIi5xdWVyeUJ1aWxkZXJCaW5kaW5nXCIpO1xuICB9LFxuICBpbml0aWFsaXplOiAoZWwpID0+IHtcbiAgICAvLyB2YXIgb3B0aW9ucyA9ICQoZWwpLmRhdGEoXCJvcHRpb25zXCIpO1xuICAgIHZhciBlbGVtZW50ID0gZG9jdW1lbnQuZ2V0RWxlbWVudEJ5SWQoZWwuaWQpO1xuICAgIHZhciBvcHRpb25zID0gZWxlbWVudC5xdWVyeVNlbGVjdG9yKCdzY3JpcHRbZGF0YS1mb3I9XCInICsgZWwuaWQgKyAnXCJdJyk7XG4gICAgdmFyIHBhcnNlZE9wdGlvbnMgPSBKU09OLnBhcnNlKG9wdGlvbnMuaW5uZXJIVE1MLCBmdW5jdGlvbiAoa2V5LCB2YWx1ZSkge1xuICAgICAgLy8gdWdseSBoYWNrIHRvIHBhcnNlIHN0cmluZ3MgdGhhdCBhcmUgZnVuY3Rpb25zIDooXG4gICAgICBpZiAodHlwZW9mIHZhbHVlID09PSBcInN0cmluZ1wiICYmIHZhbHVlLnN0YXJ0c1dpdGgoXCJmdW5jdGlvbihcIikpIHtcbiAgICAgICAgdmFsdWUgPSBfZXNjYXBlSHRtbCh2YWx1ZSk7XG4gICAgICAgIC8vIGNvbnNvbGUubG9nKHZhbHVlKTtcbiAgICAgICAgcmV0dXJuICgwLCBldmFsKShcIihcIiArIHZhbHVlICsgXCIpXCIpO1xuICAgICAgfVxuICAgICAgcmV0dXJuIHZhbHVlO1xuICAgIH0pO1xuXG4gICAgJChcIiNcIiArIGVsLmlkKS5xdWVyeUJ1aWxkZXIocGFyc2VkT3B0aW9ucyk7XG4gIH0sXG4gIGdldFZhbHVlOiAoZWwpID0+IHtcbiAgICB2YXIgcnVsZXMgPSAkKFwiI1wiICsgZWwuaWQpLnF1ZXJ5QnVpbGRlcihcImdldFJ1bGVzXCIpO1xuICAgIHZhciBzcWxfcnVsZXMgPSAkKFwiI1wiICsgZWwuaWQpLnF1ZXJ5QnVpbGRlcihcImdldFNRTFwiKTtcbiAgICByZXR1cm4geyBydWxlczogcnVsZXMsIHNxbF9ydWxlczogc3FsX3J1bGVzIH07XG4gIH0sXG4gIHNldFZhbHVlOiAoZWwsIHZhbHVlKSA9PiB7XG4gICAgLy8gUmVtb3ZlIGFsbCBmaWx0ZXJzIGFuZCByZXBsYWNlIHdpdGggbmV3IG9uZXNcbiAgICBjb25zb2xlLmxvZyh2YWx1ZS5zZXRGaWx0ZXJzLCB2YWx1ZS5zZXRSdWxlcywgdmFsdWUuZGVzdG9yeSwgdmFsdWUucmVzZXQpO1xuICAgIGlmICh2YWx1ZS5zZXRGaWx0ZXJzICE9IG51bGwpIHtcbiAgICAgICQoXCIjXCIgKyBlbC5pZCkucXVlcnlCdWlsZGVyKFwic2V0RmlsdGVyc1wiLCB0cnVlLCB2YWx1ZS5zZXRGaWx0ZXJzKTtcbiAgICB9XG4gICAgLy8gVXBkYXRlIHF1ZXJ5QnVpbGRlciB3aXRoIGEgc2V0IG9mIHJ1bGVzXG4gICAgaWYgKHZhbHVlLnNldFJ1bGVzICE9IG51bGwpIHtcbiAgICAgICQoXCIjXCIgKyBlbC5pZCkucXVlcnlCdWlsZGVyKFwic2V0UnVsZXNcIiwgdmFsdWUuc2V0UnVsZXMpO1xuICAgIH1cbiAgICAvLyBkZXN0b3J5IHF1ZXJ5QnVpbGRlclxuICAgIGlmICh2YWx1ZS5kZXN0b3J5KSB7XG4gICAgICAkKFwiI1wiICsgZWwuaWQpLnF1ZXJ5QnVpbGRlcihcImRlc3RvcnlcIik7XG4gICAgfVxuICAgIC8vIHJlc2V0IHF1ZXJ5QnVpbGRlclxuICAgIGlmICh2YWx1ZS5yZXNldCkge1xuICAgICAgJChcIiNcIiArIGVsLmlkKS5xdWVyeUJ1aWxkZXIoXCJyZXNldFwiKTtcbiAgICB9XG4gIH0sXG4gIHN1YnNjcmliZTogKGVsLCBjYWxsYmFjaykgPT4ge1xuICAgICQoZWwpLm9uKFxuICAgICAgYFxuICAgICBhZnRlck1vdmUucXVlcnlCdWlsZGVyIFxuICAgICBhZnRlclNldFJ1bGVzLnF1ZXJ5QnVpbGRlciBcbiAgICAgYWZ0ZXJDcmVhdGVSdWxlSW5wdXQucXVlcnlCdWlkbGVyIFxuICAgICBhZnRlckluaXQucXVlcnlCdWlsZGVyIFxuICAgICBhZnRlckRlbGV0ZUdyb3VwLnF1ZXJ5QnVpbGRlciBcbiAgICAgYWZ0ZXJEZWxldGVSdWxlLnF1ZXJ5QnVpbGRlclxuICAgICBhZnRlclVwZGF0ZVJ1bGVWYWx1ZS5xdWVyeUJ1aWxkZXIgXG4gICAgIGFmdGVyVXBkYXRlUnVsZUZpbHRlci5xdWVyeUJ1aWxkZXIgXG4gICAgIGFmdGVyVXBkYXRlUnVsZU9wZXJhdG9yLnF1ZXJ5QnVpbGRlciAgXG4gICAgIGFmdGVyVXBkYXRlR3JvdXBDb25kaXRpb24ucXVlcnlCdWlsZGVyXG4gICAgIGAsXG4gICAgICBmdW5jdGlvbiAoZSkge1xuICAgICAgICBjYWxsYmFjaygpO1xuICAgICAgfVxuICAgICk7XG4gIH0sXG4gIHVuc3Vic2NyaWJlOiAoZWwpID0+IHtcbiAgICAkKGVsKS5vZmYoXCIucXVlcnlCdWlsZGVyQmluZGluZ1wiKTtcbiAgfSxcbiAgcmVjZWl2ZU1lc3NhZ2U6IGZ1bmN0aW9uIChlbCwgZGF0YSkge1xuICAgIC8vIGNvbnNvbGUubG9nKGRhdGEpO1xuICAgIHRoaXMuc2V0VmFsdWUoZWwsIGRhdGEpO1xuICAgIC8vIG90aGVyIHBhcmFtZXRlcnMgdG8gdXBkYXRlLi4uXG4gIH0sXG59KTtcblxuU2hpbnkuaW5wdXRCaW5kaW5ncy5yZWdpc3RlcihxdWVyeUJ1aWxkZXJCaW5kaW5nLCBcInFici5xdWVyeUJ1aWxkZXJCaW5kaW5nXCIpO1xuIl0sIm5hbWVzIjpbXSwic291cmNlUm9vdCI6IiJ9