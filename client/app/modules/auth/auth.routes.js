(function () {
  'use strict';

  /**
    mtgTracker.auth

    Startup configurations for mtgTracker.auth
   */

   angular
    .module('mtgTracker.auth')
    .config(AuthRoutes);

  // AuthRoutes.$inject = [ '$stateProvider' ];

  /* @ngInject */
  function AuthRoutes ($stateProvider) {

    $stateProvider
      .state('login', {
        url: "/login",
        templateUrl: "modules/auth/views/login.html",
        controller: 'LoginCtrl as LoginCtrl'
      })
      .state('logout', {
        url: "/logout",
        controller: function LogoutCtrl ($log, $auth, $state) {
          $log.debug('Logout')
          $auth.logout()
            .then(function() {
              $state.go('home');
            });
        }
      })
      .state('signup', {
        url: "/signup",
        templateUrl: "modules/auth/views/signup.html",
        controller: 'SignupCtrl as SignupCtrl'
      });

  };
  
}());
