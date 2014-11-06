(function() {
  'use strict';

  // Declare app level module which depends on filters, and services
  angular.module('mtgTracker', [
    'ui.router',
    'ui.bootstrap',
    'ui.router.breadcrumbs',
    'ui.bootstrap.formErrors',
    'mtgImage',
    'mtgTracker.api',
    'mtgTracker.flash',
    'mtgTracker.auth',
    'mtgTracker.collections',
    'mtgTracker.cards'
  ]);

  angular.module('mtgTracker')
    .run(function($rootScope, $state) {
      // https://github.com/angular-ui/ui-router/wiki#state-change-events
      $rootScope.$on('$stateChangeStart', 
        function(event, toState, toParams, fromState, fromParams) {
          console.info(event.name, fromState.name, toState.name);
          // console.debug(arguments);
        });

      $rootScope.$on('$stateNotFound', 
        function(event, unfoundState, fromState, fromParams) { 
          console.info(event.name, unfoundState.to);
          // console.debug(arguments);
        });

      $rootScope.$on('$stateChangeSuccess', 
        function(event, toState, toParams, fromState, fromParams) {
          console.info(event.name, fromState.name, toState.name);
          // console.debug(arguments);
        });

      $rootScope.$on('$stateChangeError', 
        function(event, toState, toParams, fromState, fromParams, error){
          // console.debug(arguments);
          console.error(event.name, fromState.name, toState.name, error.status, error.statusText);
          // console.error(error.stack);
          
          if (error.status === 401) {
            $state.go('login');
          }
        });

    });

}());
