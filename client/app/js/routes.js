(function() {
  'use strict';

  var module = angular.module('mtgTracker');

  module.config(function($stateProvider, $urlRouterProvider) {
    //
    // For any unmatched url, redirect to /state1
    $urlRouterProvider.otherwise("/collection");
    //
    // Now set up the states
    $stateProvider
      .state('collection', {
        url: "/collection",
        templateUrl: "views/collection/index.html",
        controller: 'CollectionCtrl'
      })
      .state('card', {
        url: '/card/:id',
        templateUrl: 'views/card/show.html',
        controller: 'CardCtrl'
      });
  });

}());
