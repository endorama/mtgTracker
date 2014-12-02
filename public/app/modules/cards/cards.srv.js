(function() {
  'use strict';

  /**
    mtgTracker.cards[CardsSrv]

    Retrieve cards from api
   */
  
  angular
    .module('mtgTracker.cards')
    .service('CardsSrv', CardsSrv);

  // CardsSrv.$inject = [ 'Api' ];

  function CardsSrv (Api) {
    var self = this;

    this.one = function (id) {
      return Api.one('cards', id).get();
    };

    return this;

  };

}());
