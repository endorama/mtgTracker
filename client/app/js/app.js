(function() {
  'use strict';

  // Declare app level module which depends on filters, and services
  angular.module('mtgTracker', [
    'ui.router',
    'ui.bootstrap',
    'mtgTracker.api',
    'mtgTracker.auth',
    'mtgTracker.collections'
  ]);

  angular.module('mtgTracker')
    .run(function($rootScope) {
      // https://github.com/angular-ui/ui-router/wiki#state-change-events
      $rootScope.$on('$stateChangeStart', 
        function(event, toState, toParams, fromState, fromParams) {
          console.warn(event.name);
          // console.debug(arguments);
        });

      $rootScope.$on('$stateNotFound', 
        function(event, unfoundState, fromState, fromParams) { 
          console.warn(event.name);
          // console.debug(arguments);
        });

      $rootScope.$on('$stateChangeSuccess', 
        function(event, toState, toParams, fromState, fromParams) {
          console.warn(event.name);
          // console.debug(arguments);
        });

      $rootScope.$on('$stateChangeError', 
        function(event, toState, toParams, fromState, fromParams, error){
          console.error(event.name, error.message);
          console.error(error.stack);
        });

    });

}());
