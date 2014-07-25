(function() {
  'use strict';

  function CollectionCtrl($scope) {

    $scope.rarityDropdown = [
      { label: 'Mythic', value: 'Mythic'},
      { label: 'Rare', value: 'Rare'},
      { label: 'Uncommon', value: 'Uncommon'},
      { label: 'Common', value: 'Common'},
    ];

  }

  angular
    .module('mtgTracker')
    .controller('CollectionCtrl', CollectionCtrl);

}());
