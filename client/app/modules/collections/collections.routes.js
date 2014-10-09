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
      .state('collections.index', {
        url: '/',
        templateUrl: 'modules/collections/views/index/template.html',
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
        templateUrl: 'modules/collections/views/show/template.html',
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

  };
  
}());
