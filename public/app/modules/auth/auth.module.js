(function () {
  'use strict';

  /**
    mtgTracker.auth

    Handles authentication

    It uses Satellizer library ( see https://github.com/sahat/satellizer for 
    docs )
   */

  angular
    .module('mtgTracker.auth', [ 
      'mtgTracker.api',
      'mtgTracker.flash',
      'ui.router',
      'satellizer'
    ]);

}());
