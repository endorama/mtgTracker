(function() {
  'use strict';

  angular
    .module('mtgTracker.collections')
    .service('CollectionsSrv', Service);

  Service.$inject = [ 'Api' ];

  function Service(Api) {
    var self = this;

    this.all     = all;
    this.cards   = cards;
    this.create  = create;
    this.one     = one;

    //////////

    function all () {
      return Api.all('collections').getList();
    }

    function cards (id) {
      return Api.one('collections', id).all('cards').getList();
    }

    function create (collection) {
      return Api.all('collections').post(collection);
    }

    function one (id) {   
      return Api.one('collections', id).get(); 
    }

    return this;
  };

}());
