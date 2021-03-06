(function () {
  'use strict';

  /**
    mtgTracker.collections

    Routes for mtgTracker.collections
   */

   angular
    .module('mtgTracker.collections')
    .config(CollectionsRoutes);

  // CollectionsRoutes.$inject = [ '$stateProvider' ];

  /* @ngInject */
  function CollectionsRoutes ($stateProvider) {

    $stateProvider
      .state('collections', {
        url: '/collections',
        abstract: true,
        template: '<div ui-view></div>',
        breadcrumb: 'Collections'
      })
      .state('collections.create', {
        url: '/create',
        templateUrl: 'modules/collections/views/create.html',
        controller: 'CollectionsCreateCtrl as CollectionsCreateCtrl',
        breadcrumb: 'New Collection'
      })
      .state('collections.index', {
        url: '/',
        templateUrl: 'modules/collections/views/index.html',
        controller: 'CollectionsIndexCtrl as CollectionsIndexCtrl',
        resolve: {
          collections: function(CollectionsSrv) {
            return CollectionsSrv.all();
          }
        },
        breadcrumb: 'Collections'
      })
      .state('collections.show', {
        url: '/:id',
        templateUrl: 'modules/collections/views/show.html',
        controller: 'CollectionsShowCtrl as CollectionsShowCtrl',
        resolve: {
          collection: function($stateParams, CollectionsSrv) {
            console.log('resolve', $stateParams)
            return CollectionsSrv.one($stateParams.id);
          },
          cards: function($stateParams, CollectionsSrv) {
            console.log('resolve', $stateParams)
            return CollectionsSrv.cards($stateParams.id);
          }
        },
        // breadcrumb: 'Collections'
      })
      .state('collections.edit', {
        url: '/:id/edit',
        templateUrl: 'modules/collections/views/edit.html',
        controller: 'CollectionsEditCtrl as CollectionsEditCtrl',
        resolve: {
          collection: function($stateParams, CollectionsSrv) {
            return CollectionsSrv.one($stateParams.id);
          }
        },
        // breadcrumb: 'Collections'
      })
      .state('collections.addCard', {
        url: '/:id/addCard',
        templateUrl: 'modules/collections/views/addCard.html',
        controller: 'CollectionsAddCardCtrl as CollectionsAddCardCtrl',
        resolve: {
          collection: function($stateParams, CollectionsSrv) {
            return CollectionsSrv.one($stateParams.id);
          }
        },
      });

  };
  
}());
