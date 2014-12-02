(function (jq) {
  'use strict';
  // https://github.com/johnpapa/angularjs-styleguide#directives

  /**
    ui.bootstrap.glyphicon[glyphicon] Directive

    Insert a glyphicon as required by Bootstrap 3.0.

    Example:
      <i glyphicon="circle-arrow-up"></i>
   */

   angular
    .module('ui.bootstrap.glyphicon')
    .directive('glyphicon', glyphicon);

  // glyphicon.$inject = [ '' ];

  /* @ngInject */
  function glyphicon () {
    var directive = {
      link: postLinkFunction,
      restrict: 'A',
      // replace: true,
      scope: false,
      // template: '<i class="glyphicon"></i>'
    };
    return directive;

    function postLinkFunction (scope, element, attributes) {
      element.addClass('glyphicon');
      element.addClass('glyphicon-' + attributes.glyphicon);
    };

  };
  
}(angular.element));
