// https://gist.github.com/endorama/11399642#file-service-js
(function() {
  'use strict';

  angular
    .module('mtgTracker.api')
    .service('Api', Service);

  Service.$inject = [ 'Restangular' ];

  function Service(Restangular) {
    return Restangular;
  };

}());
