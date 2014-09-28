(function () {
  /**
    mtgTracker

    Startup configurations for mtgTracker
   */

   angular
    .module('mtgTracker')
    .config(ConfigFunction);

  // ConfigFunction. = [  ];

  function ConfigFunction ($httpProvider) {

    // intercept HTTP errors
    $httpProvider.interceptors.push(function($q) {
      return {
        'request': function(config) {
          // console.debug('request', config)
          return config;
        },

        'requestError': function(rejection) {
          // console.debug('requestError', rejection)
          return $q.reject(rejection);
        },

        'response': function(response) {
          // console.debug('response', response)
          return response;
        },

        'responseError': function(rejection) {
          // console.debug('responseError', rejection)
          alert('An error occurred trying to reach ' + rejection.config.url + ':\n'+rejection.message);
          return $q.reject(rejection);
        }
      };
    });

  };
}());
