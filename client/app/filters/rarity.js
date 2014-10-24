(function() {
  'use strict';
  
  /**
    mtgTracker rarity filter

    Return the long name for the filter card attribute
   */

  angular
    .module('mtgTracker')
    .filter('rarity', rarityFilter);

  /* @ngInject */
  function rarityFilter() {
    return applyFilter;

    function applyFilter(input) {
      var rarity;
      switch (input) {
        case 'mythic':
          rarity = 'Mythic Rare';
          break;
        case 'rare': 
          rarity = 'Rare';
          break;
        case 'uncommon':
          rarity = 'Uncommon';
          break;
        case 'common':
          rarity = 'Common';
          break;
        case 'special':
          rarity = 'Special';
          break;
        case 'land':
          rarity = 'Land';
          break;
      }

      return rarity;
    }
  }  

}());
