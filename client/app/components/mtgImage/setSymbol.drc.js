(function (jq) {
  'use strict';
  // https://github.com/johnpapa/angularjs-styleguide#directives

  /**
    mtgImage[setSymbol] Directive

    Display a SET symbol
   */

   angular
    .module('mtgImage')
    .directive('setSymbol', setSymbol);

  // setSymbol.$inject = [ '' ];

  /* @ngInject */
  function setSymbol (mtgImage) {
    var directive = {
      link: linkFunction,
      replace: true,
      restrict: 'E',
      template: '<img ng-src="{{image}}" tooltip="{{name}}" />'
    };
    return directive;

    function linkFunction (scope, element, attributes) {
      validateAttributes();

      scope.image = mtgImage.getSet(attributes.code);
      // assignTooltip();
      scope.name = attributes.name;
      calculateWidth();

      //////////

      function validateAttributes() {
        if (!attributes.code) { throw 'Code is required'; }
      }

      function assignTooltip() {
        if (attributes.name) {
          element.attr('tooltip', attributes.name);
        }
      }

      function calculateWidth() {
        switch (attributes.width) {
          case 'small':
            element.attr('width', 30);
            break;
          
          default:
            element.attr('width', 50);
        }
      }
    };

  };
  
}(angular.element));
