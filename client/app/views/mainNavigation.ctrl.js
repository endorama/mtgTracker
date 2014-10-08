(function() {
  'use strict';
  // https://github.com/johnpapa/angularjs-styleguide#controllers
  
  angular
    .module('mtgTracker')
    .controller('MainNavigationCtrl', MainNavigationCtrl);

  // MainNavigationCtrl.$inject = [ '$scope' ];

  function MainNavigationCtrl ($scope, AuthSrv) {
    var vm = this;

    vm.collapsed = true;
    vm.current_user = get_user();
    vm.is_authenticated = AuthSrv.isAuthenticated;

    //////////

    function get_user () {
      return AuthSrv.current_user().then(function(result) { vm.current_user = result; });
    }

  };

}());
