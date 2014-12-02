(function (jq) {
  'use strict';
  // https://github.com/johnpapa/angularjs-styleguide#directives

  /**
    ui.bootstrap.formErrors[hasError] Directive

    To be used on element on which is necessary to display the .has-error 
    Bootstrap class on form input errors.
   */

   angular
    .module('ui.bootstrap.formErrors')
    .directive('hasErrorOn', hasErrorOn);

  // hasError.$inject = [ '' ];

  /* @ngInject */
  function hasErrorOn () {
    var directive = {
      controller: controllerFunction,
      link: linkFunction,
      restrict: 'A',
      require: '^form',
    };
    return directive;

    function controllerFunction () {}

    function linkFunction (scope, element, attributes, formCtrl) {
      var attrName = attributes.hasErrorOn;
      
      jq(element)
        .parents('form')
        .find('input[name="'+attrName+'"]')
        .bind('keyup', function() {
          element.toggleClass('has-error', hasError());
        });

      scope.$watch(function () {
        return formCtrl[attrName] && hasError();
      }, function (newVal) {
        element.toggleClass('has-error', newVal);
      });

      function hasError () {
        return formCtrl[attrName].$dirty && formCtrl[attrName].$invalid;
      }

    };

  };
  
}(angular.element));
