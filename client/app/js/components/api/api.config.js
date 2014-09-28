(function() {
  'use strict';

  angular
    .module('mtgTracker.api')
    .config(Config);

  Config.$inject = [ 'RestangularProvider' ];

  function Config(RestangularProvider) {
    RestangularProvider.setBaseUrl('http://localhost:4567');
  };

}());
