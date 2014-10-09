(function() {
  'use strict';

  var module = angular.module('mtgTracker');

  module.config(function($stateProvider, $urlRouterProvider) {
    //
    // For any unmatched url, redirect to 
    $urlRouterProvider.otherwise("/");
    //
    // Now set up the states
    $stateProvider
      .state('home', {
        url: '/',
        templateUrl: "views/home.html",
        controller: 'HomeCtrl as HomeCtrl',
      })
      .state('cards', {
        url: '/cards/:id',
        templateUrl: 'modules/cards/views/show/template.html',
        controller: 'CardShowCtrl as CardShowCtrl',
        resolve: {
          card: function($stateParams, CardsSrv) {
            return CardsSrv.one($stateParams.id);
          }
        }
      });
  });

}());
