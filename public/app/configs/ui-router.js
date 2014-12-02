(function () {
  'use strict';

  /**
    mtgTracker

    Startup configurations for UIRouter
   */

   angular
    .module('mtgTracker')
    .config(UIRouterConfig);

  // UIRouterConfig.$inject = [ '$provide' ];

  /* @ngInject */
  function UIRouterConfig ($provide) {
    // http://stackoverflow.com/a/23198743
    $provide.decorator('$state', function($delegate, $stateParams) {
      $delegate.forceReload = function() {
        return $delegate.go($delegate.current, $stateParams, {
          reload: true,
          inherit: false,
          notify: true
        });
      };
      return $delegate;
    });

  };
  
}());
