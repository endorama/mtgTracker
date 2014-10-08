(function() {
  'use strict';

  // Declare app level module which depends on filters, and services
  angular.module('mtgTracker', [
    'ui.router',
    'ui.bootstrap',
    'ui.router.breadcrumbs',
    'mtgTracker.api',
    'mtgTracker.auth',
    'mtgTracker.collections'
  ]);

  angular.module('mtgTracker')
    .run(function($rootScope, $state) {
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
          console.debug(arguments);
          console.error(event.name, error.status, error.statusText);
          if (error.status === 401) {
            $state.go('login');
            
          }
          // console.error(error.stack);
        });

    });

}());
