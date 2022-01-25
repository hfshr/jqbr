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
        console.log(value);
        value = _escapeHtml(value);
        console.log(value);
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
//# sourceMappingURL=data:application/json;charset=utf-8;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoicXVlcnlCdWlsZGVyLmpzIiwibWFwcGluZ3MiOiI7Ozs7Ozs7Ozs7QUFBQTs7Ozs7Ozs7OztBQ0FBOzs7Ozs7VUNBQTtVQUNBOztVQUVBO1VBQ0E7VUFDQTtVQUNBO1VBQ0E7VUFDQTtVQUNBO1VBQ0E7VUFDQTtVQUNBO1VBQ0E7VUFDQTtVQUNBOztVQUVBO1VBQ0E7O1VBRUE7VUFDQTtVQUNBOzs7OztXQ3RCQTtXQUNBO1dBQ0E7V0FDQTtXQUNBO1dBQ0EsaUNBQWlDLFdBQVc7V0FDNUM7V0FDQTs7Ozs7V0NQQTtXQUNBO1dBQ0E7V0FDQTtXQUNBLHlDQUF5Qyx3Q0FBd0M7V0FDakY7V0FDQTtXQUNBOzs7OztXQ1BBOzs7OztXQ0FBO1dBQ0E7V0FDQTtXQUNBLHVEQUF1RCxpQkFBaUI7V0FDeEU7V0FDQSxnREFBZ0QsYUFBYTtXQUM3RDs7Ozs7Ozs7Ozs7Ozs7O0FDTnVCO0FBQ1I7O0FBRWY7QUFDQTtBQUNBLHNCQUFzQjtBQUN0QixxQkFBcUI7QUFDckIscUJBQXFCO0FBQ3JCOztBQUVBOztBQUVBLG9EQUFRO0FBQ1I7QUFDQSxXQUFXLDZDQUFDO0FBQ1osR0FBRztBQUNIO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0EsS0FBSzs7QUFFTCxJQUFJLDZDQUFDO0FBQ0wsR0FBRztBQUNIO0FBQ0EsZ0JBQWdCLDZDQUFDO0FBQ2pCLG9CQUFvQiw2Q0FBQztBQUNyQixhQUFhO0FBQ2IsR0FBRztBQUNIO0FBQ0E7QUFDQTtBQUNBO0FBQ0EsTUFBTSw2Q0FBQztBQUNQO0FBQ0E7QUFDQTtBQUNBLE1BQU0sNkNBQUM7QUFDUDtBQUNBO0FBQ0E7QUFDQSxNQUFNLDZDQUFDO0FBQ1A7QUFDQTtBQUNBO0FBQ0EsTUFBTSw2Q0FBQztBQUNQO0FBQ0EsR0FBRztBQUNIO0FBQ0EsSUFBSSw2Q0FBQztBQUNMO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0EsR0FBRztBQUNIO0FBQ0EsSUFBSSw2Q0FBQztBQUNMLEdBQUc7QUFDSDtBQUNBO0FBQ0E7QUFDQTtBQUNBLEdBQUc7QUFDSCxDQUFDOztBQUVEIiwic291cmNlcyI6WyJ3ZWJwYWNrOi8vcWJyL2V4dGVybmFsIHZhciBcIlNoaW55XCIiLCJ3ZWJwYWNrOi8vcWJyL2V4dGVybmFsIHZhciBcImpRdWVyeVwiIiwid2VicGFjazovL3Fici93ZWJwYWNrL2Jvb3RzdHJhcCIsIndlYnBhY2s6Ly9xYnIvd2VicGFjay9ydW50aW1lL2NvbXBhdCBnZXQgZGVmYXVsdCBleHBvcnQiLCJ3ZWJwYWNrOi8vcWJyL3dlYnBhY2svcnVudGltZS9kZWZpbmUgcHJvcGVydHkgZ2V0dGVycyIsIndlYnBhY2s6Ly9xYnIvd2VicGFjay9ydW50aW1lL2hhc093blByb3BlcnR5IHNob3J0aGFuZCIsIndlYnBhY2s6Ly9xYnIvd2VicGFjay9ydW50aW1lL21ha2UgbmFtZXNwYWNlIG9iamVjdCIsIndlYnBhY2s6Ly9xYnIvLi9zcmNqcy9pbnB1dHMvcXVlcnlCdWlsZGVyLmpzIl0sInNvdXJjZXNDb250ZW50IjpbIm1vZHVsZS5leHBvcnRzID0gU2hpbnk7IiwibW9kdWxlLmV4cG9ydHMgPSBqUXVlcnk7IiwiLy8gVGhlIG1vZHVsZSBjYWNoZVxudmFyIF9fd2VicGFja19tb2R1bGVfY2FjaGVfXyA9IHt9O1xuXG4vLyBUaGUgcmVxdWlyZSBmdW5jdGlvblxuZnVuY3Rpb24gX193ZWJwYWNrX3JlcXVpcmVfXyhtb2R1bGVJZCkge1xuXHQvLyBDaGVjayBpZiBtb2R1bGUgaXMgaW4gY2FjaGVcblx0dmFyIGNhY2hlZE1vZHVsZSA9IF9fd2VicGFja19tb2R1bGVfY2FjaGVfX1ttb2R1bGVJZF07XG5cdGlmIChjYWNoZWRNb2R1bGUgIT09IHVuZGVmaW5lZCkge1xuXHRcdHJldHVybiBjYWNoZWRNb2R1bGUuZXhwb3J0cztcblx0fVxuXHQvLyBDcmVhdGUgYSBuZXcgbW9kdWxlIChhbmQgcHV0IGl0IGludG8gdGhlIGNhY2hlKVxuXHR2YXIgbW9kdWxlID0gX193ZWJwYWNrX21vZHVsZV9jYWNoZV9fW21vZHVsZUlkXSA9IHtcblx0XHQvLyBubyBtb2R1bGUuaWQgbmVlZGVkXG5cdFx0Ly8gbm8gbW9kdWxlLmxvYWRlZCBuZWVkZWRcblx0XHRleHBvcnRzOiB7fVxuXHR9O1xuXG5cdC8vIEV4ZWN1dGUgdGhlIG1vZHVsZSBmdW5jdGlvblxuXHRfX3dlYnBhY2tfbW9kdWxlc19fW21vZHVsZUlkXShtb2R1bGUsIG1vZHVsZS5leHBvcnRzLCBfX3dlYnBhY2tfcmVxdWlyZV9fKTtcblxuXHQvLyBSZXR1cm4gdGhlIGV4cG9ydHMgb2YgdGhlIG1vZHVsZVxuXHRyZXR1cm4gbW9kdWxlLmV4cG9ydHM7XG59XG5cbiIsIi8vIGdldERlZmF1bHRFeHBvcnQgZnVuY3Rpb24gZm9yIGNvbXBhdGliaWxpdHkgd2l0aCBub24taGFybW9ueSBtb2R1bGVzXG5fX3dlYnBhY2tfcmVxdWlyZV9fLm4gPSAobW9kdWxlKSA9PiB7XG5cdHZhciBnZXR0ZXIgPSBtb2R1bGUgJiYgbW9kdWxlLl9fZXNNb2R1bGUgP1xuXHRcdCgpID0+IChtb2R1bGVbJ2RlZmF1bHQnXSkgOlxuXHRcdCgpID0+IChtb2R1bGUpO1xuXHRfX3dlYnBhY2tfcmVxdWlyZV9fLmQoZ2V0dGVyLCB7IGE6IGdldHRlciB9KTtcblx0cmV0dXJuIGdldHRlcjtcbn07IiwiLy8gZGVmaW5lIGdldHRlciBmdW5jdGlvbnMgZm9yIGhhcm1vbnkgZXhwb3J0c1xuX193ZWJwYWNrX3JlcXVpcmVfXy5kID0gKGV4cG9ydHMsIGRlZmluaXRpb24pID0+IHtcblx0Zm9yKHZhciBrZXkgaW4gZGVmaW5pdGlvbikge1xuXHRcdGlmKF9fd2VicGFja19yZXF1aXJlX18ubyhkZWZpbml0aW9uLCBrZXkpICYmICFfX3dlYnBhY2tfcmVxdWlyZV9fLm8oZXhwb3J0cywga2V5KSkge1xuXHRcdFx0T2JqZWN0LmRlZmluZVByb3BlcnR5KGV4cG9ydHMsIGtleSwgeyBlbnVtZXJhYmxlOiB0cnVlLCBnZXQ6IGRlZmluaXRpb25ba2V5XSB9KTtcblx0XHR9XG5cdH1cbn07IiwiX193ZWJwYWNrX3JlcXVpcmVfXy5vID0gKG9iaiwgcHJvcCkgPT4gKE9iamVjdC5wcm90b3R5cGUuaGFzT3duUHJvcGVydHkuY2FsbChvYmosIHByb3ApKSIsIi8vIGRlZmluZSBfX2VzTW9kdWxlIG9uIGV4cG9ydHNcbl9fd2VicGFja19yZXF1aXJlX18uciA9IChleHBvcnRzKSA9PiB7XG5cdGlmKHR5cGVvZiBTeW1ib2wgIT09ICd1bmRlZmluZWQnICYmIFN5bWJvbC50b1N0cmluZ1RhZykge1xuXHRcdE9iamVjdC5kZWZpbmVQcm9wZXJ0eShleHBvcnRzLCBTeW1ib2wudG9TdHJpbmdUYWcsIHsgdmFsdWU6ICdNb2R1bGUnIH0pO1xuXHR9XG5cdE9iamVjdC5kZWZpbmVQcm9wZXJ0eShleHBvcnRzLCAnX19lc01vZHVsZScsIHsgdmFsdWU6IHRydWUgfSk7XG59OyIsImltcG9ydCAkIGZyb20gXCJqcXVlcnlcIjtcbmltcG9ydCBcInNoaW55XCI7XG5cbmNvbnN0IF9lc2NhcGVIdG1sID0gKHVuc2FmZSkgPT4ge1xuICByZXR1cm4gdW5zYWZlXG4gICAgLnJlcGxhY2VBbGwoXCImYW1wO1wiLCBcIiZcIilcbiAgICAucmVwbGFjZUFsbChcIiZsdDtcIiwgXCI8XCIpXG4gICAgLnJlcGxhY2VBbGwoXCImZ3Q7XCIsIFwiPlwiKTtcbn07XG5cbnZhciBxdWVyeUJ1aWxkZXJCaW5kaW5nID0gbmV3IFNoaW55LklucHV0QmluZGluZygpO1xuXG4kLmV4dGVuZChxdWVyeUJ1aWxkZXJCaW5kaW5nLCB7XG4gIGZpbmQ6IChzY29wZSkgPT4ge1xuICAgIHJldHVybiAkKHNjb3BlKS5maW5kKFwiLnF1ZXJ5QnVpbGRlckJpbmRpbmdcIik7XG4gIH0sXG4gIGluaXRpYWxpemU6IChlbCkgPT4ge1xuICAgIC8vIHZhciBvcHRpb25zID0gJChlbCkuZGF0YShcIm9wdGlvbnNcIik7XG4gICAgdmFyIGVsZW1lbnQgPSBkb2N1bWVudC5nZXRFbGVtZW50QnlJZChlbC5pZCk7XG4gICAgdmFyIG9wdGlvbnMgPSBlbGVtZW50LnF1ZXJ5U2VsZWN0b3IoJ3NjcmlwdFtkYXRhLWZvcj1cIicgKyBlbC5pZCArICdcIl0nKTtcbiAgICB2YXIgcGFyc2VkT3B0aW9ucyA9IEpTT04ucGFyc2Uob3B0aW9ucy5pbm5lckhUTUwsIGZ1bmN0aW9uIChrZXksIHZhbHVlKSB7XG4gICAgICAvLyB1Z2x5IGhhY2sgdG8gcGFyc2Ugc3RyaW5ncyB0aGF0IGFyZSBmdW5jdGlvbnMgOihcbiAgICAgIGlmICh0eXBlb2YgdmFsdWUgPT09IFwic3RyaW5nXCIgJiYgdmFsdWUuc3RhcnRzV2l0aChcImZ1bmN0aW9uKFwiKSkge1xuICAgICAgICBjb25zb2xlLmxvZyh2YWx1ZSk7XG4gICAgICAgIHZhbHVlID0gX2VzY2FwZUh0bWwodmFsdWUpO1xuICAgICAgICBjb25zb2xlLmxvZyh2YWx1ZSk7XG4gICAgICAgIHJldHVybiAoMCwgZXZhbCkoXCIoXCIgKyB2YWx1ZSArIFwiKVwiKTtcbiAgICAgIH1cbiAgICAgIHJldHVybiB2YWx1ZTtcbiAgICB9KTtcblxuICAgICQoXCIjXCIgKyBlbC5pZCkucXVlcnlCdWlsZGVyKHBhcnNlZE9wdGlvbnMpO1xuICB9LFxuICBnZXRWYWx1ZTogKGVsKSA9PiB7XG4gICAgdmFyIHJ1bGVzID0gJChcIiNcIiArIGVsLmlkKS5xdWVyeUJ1aWxkZXIoXCJnZXRSdWxlc1wiKTtcbiAgICB2YXIgc3FsX3J1bGVzID0gJChcIiNcIiArIGVsLmlkKS5xdWVyeUJ1aWxkZXIoXCJnZXRTUUxcIik7XG4gICAgcmV0dXJuIHsgcnVsZXM6IHJ1bGVzLCBzcWxfcnVsZXM6IHNxbF9ydWxlcyB9O1xuICB9LFxuICBzZXRWYWx1ZTogKGVsLCB2YWx1ZSkgPT4ge1xuICAgIC8vIFJlbW92ZSBhbGwgZmlsdGVycyBhbmQgcmVwbGFjZSB3aXRoIG5ldyBvbmVzXG4gICAgY29uc29sZS5sb2codmFsdWUuc2V0RmlsdGVycywgdmFsdWUuc2V0UnVsZXMsIHZhbHVlLmRlc3RvcnksIHZhbHVlLnJlc2V0KTtcbiAgICBpZiAodmFsdWUuc2V0RmlsdGVycyAhPSBudWxsKSB7XG4gICAgICAkKFwiI1wiICsgZWwuaWQpLnF1ZXJ5QnVpbGRlcihcInNldEZpbHRlcnNcIiwgdHJ1ZSwgdmFsdWUuc2V0RmlsdGVycyk7XG4gICAgfVxuICAgIC8vIFVwZGF0ZSBxdWVyeUJ1aWxkZXIgd2l0aCBhIHNldCBvZiBydWxlc1xuICAgIGlmICh2YWx1ZS5zZXRSdWxlcyAhPSBudWxsKSB7XG4gICAgICAkKFwiI1wiICsgZWwuaWQpLnF1ZXJ5QnVpbGRlcihcInNldFJ1bGVzXCIsIHZhbHVlLnNldFJ1bGVzKTtcbiAgICB9XG4gICAgLy8gZGVzdG9yeSBxdWVyeUJ1aWxkZXJcbiAgICBpZiAodmFsdWUuZGVzdG9yeSkge1xuICAgICAgJChcIiNcIiArIGVsLmlkKS5xdWVyeUJ1aWxkZXIoXCJkZXN0b3J5XCIpO1xuICAgIH1cbiAgICAvLyByZXNldCBxdWVyeUJ1aWxkZXJcbiAgICBpZiAodmFsdWUucmVzZXQpIHtcbiAgICAgICQoXCIjXCIgKyBlbC5pZCkucXVlcnlCdWlsZGVyKFwicmVzZXRcIik7XG4gICAgfVxuICB9LFxuICBzdWJzY3JpYmU6IChlbCwgY2FsbGJhY2spID0+IHtcbiAgICAkKGVsKS5vbihcbiAgICAgIGBcbiAgICAgYWZ0ZXJNb3ZlLnF1ZXJ5QnVpbGRlciBcbiAgICAgYWZ0ZXJTZXRSdWxlcy5xdWVyeUJ1aWxkZXIgXG4gICAgIGFmdGVyQ3JlYXRlUnVsZUlucHV0LnF1ZXJ5QnVpZGxlciBcbiAgICAgYWZ0ZXJJbml0LnF1ZXJ5QnVpbGRlciBcbiAgICAgYWZ0ZXJEZWxldGVHcm91cC5xdWVyeUJ1aWxkZXIgXG4gICAgIGFmdGVyRGVsZXRlUnVsZS5xdWVyeUJ1aWxkZXJcbiAgICAgYWZ0ZXJVcGRhdGVSdWxlVmFsdWUucXVlcnlCdWlsZGVyIFxuICAgICBhZnRlclVwZGF0ZVJ1bGVGaWx0ZXIucXVlcnlCdWlsZGVyIFxuICAgICBhZnRlclVwZGF0ZVJ1bGVPcGVyYXRvci5xdWVyeUJ1aWxkZXIgIFxuICAgICBhZnRlclVwZGF0ZUdyb3VwQ29uZGl0aW9uLnF1ZXJ5QnVpbGRlclxuICAgICBgLFxuICAgICAgZnVuY3Rpb24gKGUpIHtcbiAgICAgICAgY2FsbGJhY2soKTtcbiAgICAgIH1cbiAgICApO1xuICB9LFxuICB1bnN1YnNjcmliZTogKGVsKSA9PiB7XG4gICAgJChlbCkub2ZmKFwiLnF1ZXJ5QnVpbGRlckJpbmRpbmdcIik7XG4gIH0sXG4gIHJlY2VpdmVNZXNzYWdlOiBmdW5jdGlvbiAoZWwsIGRhdGEpIHtcbiAgICAvLyBjb25zb2xlLmxvZyhkYXRhKTtcbiAgICB0aGlzLnNldFZhbHVlKGVsLCBkYXRhKTtcbiAgICAvLyBvdGhlciBwYXJhbWV0ZXJzIHRvIHVwZGF0ZS4uLlxuICB9LFxufSk7XG5cblNoaW55LmlucHV0QmluZGluZ3MucmVnaXN0ZXIocXVlcnlCdWlsZGVyQmluZGluZywgXCJxYnIucXVlcnlCdWlsZGVyQmluZGluZ1wiKTtcbiJdLCJuYW1lcyI6W10sInNvdXJjZVJvb3QiOiIifQ==