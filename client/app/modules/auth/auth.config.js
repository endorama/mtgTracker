(function () {
  'use strict';

  /**
    mtgTracker.auth

    Startup configurations for mtgTracker.auth
   */

   angular
    .module('mtgTracker.auth')
    .config(SatellizerConfig);

  // SatellizerConfig.$inject = [ '$authProvider' ];

  /* @ngInject */
  function SatellizerConfig ($authProvider) {

    $authProvider.loginUrl = 'http://localhost:4567/auth/login';
    $authProvider.signupUrl = 'http://localhost:4567/auth/signup';

  };
  
}()); 
