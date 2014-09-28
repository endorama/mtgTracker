(function() {
  'use strict';
  // https://github.com/johnpapa/angularjs-styleguide#controllers
  
  angular
    .module('mtgTracker')
    .controller('MainNavigationCtrl', MainNavigationCtrl);

  // MainNavigationCtrl.$inject = [ '$scope' ];

  function MainNavigationCtrl ($scope) {
    var vm = this;

    vm.collapsed = true;

  };

}());
