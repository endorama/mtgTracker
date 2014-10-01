(function () {
  'use strict';
  // https://github.com/johnpapa/angularjs-styleguide#controllers
  
  angular
    .module('mtgTracker.auth')
    .controller('LogoutCtrl', LogoutCtrl);

  // LogoutCtrl.$inject = [  ];

  /* @ngInject */
  function LogoutCtrl ($log, $auth) {
    var vm = this;
    

    activate();

    //////////

    function activate () {
      $log.debug('Logout')
      $auth.logout()
    }
  };

}());
