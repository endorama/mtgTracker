(function (jq) {
  'use strict';
  // https://github.com/johnpapa/angularjs-styleguide#directives

  /**
    mtgImage[raritySymbol] Directive

    Display a RARITY symbol
   */

   angular
    .module('mtgImage')
    .directive('raritySymbol', raritySymbol);

  // raritySymbol.$inject = [ '' ];

  /* @ngInject */
  function raritySymbol ($filter, mtgImage) {
    var directive = {
      link: linkFunction,
      replace: true,
      restrict: 'E',
      template: '<img ng-src="{{image}}" tooltip="{{name}}" />'
    };
    return directive;

    function linkFunction (scope, element, attributes) {
      validateAttributes();

      scope.image = mtgImage.getSetRarity(attributes.code, attributes.rarity);
      assignTooltip();
      calculateWidth();

      //////////

      function validateAttributes() {
        if (!attributes.code) { throw 'Code is required'; }
        if (!attributes.rarity) { throw 'Rarity is required'; }
      }

      function assignTooltip() {
        scope.name = $filter('rarity')(attributes.rarity);
      }

      function calculateWidth() {
        element.attr('width', mtgImage.calculateWidth(attributes.width));
      }
    };

  };
  
}(angular.element));
