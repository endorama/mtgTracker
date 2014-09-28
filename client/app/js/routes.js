(function() {
  'use strict';

  var module = angular.module('mtgTracker');

  module.config(function($stateProvider, $urlRouterProvider) {
    //
    // For any unmatched url, redirect to /state1
    $urlRouterProvider.otherwise("/collections");
    //
    // Now set up the states
    $stateProvider
      .state('collections', {
        url: "/collections",
        templateUrl: "modules/collections/views/index/template.html",
        controller: 'CollectionsIndexCtrl as CollectionsIndexCtrl',
        resolve: {
          collections: function(CollectionsSrv) {
            return CollectionsSrv.all();
          }
        }
      })
      .state('collection', {
        url: "/collections/:id",
        templateUrl: "modules/collections/views/show/template.html",
        controller: 'CollectionsShowCtrl as CollectionsShowCtrl',
        resolve: {
          collection: function($stateParams, CollectionsSrv) {
            return CollectionsSrv.one($stateParams.id);
          },
          cards: function($stateParams, CollectionsSrv) {
            return CollectionsSrv.cards($stateParams.id);
          }
        }
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
