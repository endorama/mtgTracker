(function () {
  'use strict';
  // https://github.com/johnpapa/angularjs-styleguide#controllers
  
  angular
    .module('mtgTracker')
    .controller('FlashCtrl', FlashCtrl);

  // FlashCtrl.$inject = [  ];

  /* @ngInject */
  function FlashCtrl ($scope, $flash) {
    var vm = this;
    
    // activate();
    console.debug($flash.current())
    vm.flash = $flash;
    vm.closeAlert = closeAlert;

    //////////

    // $scope.$watch()

    function activate () {}

    function closeAlert () {
      console.log('destroy alert');
      vm.flash = null;
    };
  };

}());
