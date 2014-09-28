(function() {
  'use strict';
  // https://github.com/johnpapa/angularjs-styleguide#controllers

  angular
    .module('mtgTracker.collections')
    .controller('CollectionsShowCtrl', CollectionsShowCtrl);

  // CollectionsShowCtrl.$inject = [  ];

  function CollectionsShowCtrl(collection, cards) {
    var vm = this;

    vm.collection = collection;
    vm.cards = cards;

    vm.rarityDropdown = [
      { label: 'Mythic', value: 'Mythic'},
      { label: 'Rare', value: 'Rare'},
      { label: 'Uncommon', value: 'Uncommon'},
      { label: 'Common', value: 'Common'},
    ];
  };

}());
