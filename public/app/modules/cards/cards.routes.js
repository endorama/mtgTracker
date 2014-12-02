(function () {
  'use strict';

  /**
    mtgTracker.cards

    Routes for mtgTracker.cards
   */

   angular
    .module('mtgTracker.cards')
    .config(CollectionsRoutes);

  // CollectionsRoutes.$inject = [ '$stateProvider' ];

  /* @ngInject */
  function CollectionsRoutes ($stateProvider) {

    $stateProvider
      .state('cards', {
        url: '/cards',
        abstract: true,
        template: '<div ui-view></div>',
        breadcrumb: 'Cards'
      })
      .state('cards.show', {
        url: '/:id',
        templateUrl: 'modules/cards/views/show.html',
        controller: 'CardsShowCtrl as CardsShowCtrl',
        resolve: {
          card: function($stateParams, CardsSrv) {
            console.log('resolve', $stateParams)
            return CardsSrv.one($stateParams.id);
          }
        },
        // breadcrumb: 'Cards'
      });

  };
  
}());
