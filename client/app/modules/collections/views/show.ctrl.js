(function() {
  'use strict';
  // https://github.com/johnpapa/angularjs-styleguide#controllers

  angular
    .module('mtgTracker.collections')
    .controller('CollectionsShowCtrl', CollectionsShowCtrl);

  // CollectionsShowCtrl.$inject = [  ];

  function CollectionsShowCtrl(collection, cards, $log, $flash, $state) {
    var vm = this;

    vm.addCard    = addCard;
    vm.collection = collection;
    vm.cards      = cards;
    vm.removeCard = removeCard;

    //////////

    function addCard(card) {
      collection.post('cards', card)
        .then(function () {
          $flash.s('The card has been added!');
          $state.forceReload();
        })
        .catch(function (reason) {
          $log.error(reason);
          alert('Cannot add card to collection.');
        });
    }

    function removeCard(card) {
      console.debug(collection)
      // collection.remove('cards', card)
      collection.customDELETE('cards', card)
        .then(function () {
          $flash.s('The card has been removed!');
          $state.forceReload();
        })
        .catch(function (reason) {
          $log.error(reason);
          alert('Cannot remove card from collection.');
        });
    }

  };

}());
