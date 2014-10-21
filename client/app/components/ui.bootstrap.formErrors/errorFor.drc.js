(function (jq) {
  'use strict';
  // https://github.com/johnpapa/angularjs-styleguide#directives

  /**
    ui.bootstrap.formErrors[errorFor] Directive

    Show error when field specified in has-error-on is invalid for the selected
    error type.

    Requires:
      * form       as parent directive
      * hasErrorOn as parent directive

    The hasErrorOn value is used to determinate for which input this rule 
    applies.

    The errorFor value is used to determinate the kind of error this rules 
    should watch.
    Specify values as you would for the ngForm.field.$error object.
   */

   angular
    .module('ui.bootstrap.formErrors')
    .directive('errorFor', errorFor);

  // errorFor.$inject = [ '' ];

  /* @ngInject */
  function errorFor () {
    var directive = {
      link: linkFunction,
      restrict: 'A',
      scope: false,
      require: [ '^form', '^hasErrorOn' ]
    };
    return directive;

    function linkFunction (scope, element, attributes, ctrls) {
      var formCtrl       = ctrls[0];

      var errorForField     = jq(element).parents('[has-error-on]').attr('has-error-on');
      var errorForValidator = attributes.errorFor;

      scope.$watch(function () { 
        return formCtrl[errorForField].$error[errorForValidator];
      },
        function (newVal) {
          element.toggleClass('ng-hide', !newVal);
        })
    };

  };
  
}(angular.element));
