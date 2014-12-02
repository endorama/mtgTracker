(function (jq) {
  'use strict';
  // https://github.com/johnpapa/angularjs-styleguide#directives

  /**
    mtgImage[cardImage] Directive

    Show a card image
   */

   angular
    .module('mtgImage')
    .directive('cardImage', cardImage);

  // cardImage.$inject = [ '' ];

  /* @ngInject */
  function cardImage () {
    var directive = {
      link: postLinkFunction,
      replace: true,
      restrict: 'E',
      scope: false,
      template: '<img ng-src="http://mtgimage.com/card/{{image_name}}.jpg">'
    };
    return directive;

    function postLinkFunction (scope, element, attributes) {
      validateAttributes();

      scope.image_name = attributes.image;
    
      //////////

      function validateAttributes() {
        if (!attributes.image) { throw 'Image is required'; }
      }

    };

  };
  
}(angular.element));
