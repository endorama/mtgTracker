(function() {
  'use strict';

  angular
    .module('mtgTracker.collections')
    .service('CollectionsSrv', Service);

  Service.$inject = [ 'Api' ];

  function Service(Api) {
    var self = this;

    this.all = function() {
      return Api.all('collections').getList().then(function(collections) { 
        // console.debug(collections);

        // console.debug(collections.length);

        // for (var i = 0; i < collections.length; i++) {
        //   console.debug(collections[i])
        // };
        return collections
      });     
    }

    this.one = function(id) {
      // return Api.one('collections', id).get().then(function(collection) {
      //   return collection;
      // });     
      return Api.one('collections', id).get(); 
    }

    this.cards = function(id) {
      return Api.one('collections', id).all('cards').getList();
    }

    return this;
  };

}());
