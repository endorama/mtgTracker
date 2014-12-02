(function () {
  'use strict';
  // https://github.com/johnpapa/angularjs-styleguide#controllers
  
  angular
    .module('mtgTracker.auth')
    .controller('LogoutCtrl', LogoutCtrl);

  // LogoutCtrl.$inject = [  ];

  /* @ngInject */
  function LogoutCtrl (AuthSrv) {
    var vm = this;

    activate();

    //////////

    function activate () {
      AuthSrv.logout();
    }
  };

}());
