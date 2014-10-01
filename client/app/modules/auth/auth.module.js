(function () {
  'use strict';

  /**
    mtgTracker.auth

    Handles authentication
   */

  angular
    .module('mtgTracker.auth', [ 
      'mtgTracker.api',
      'ui.router',
      'satellizer'
    ]);

}());
