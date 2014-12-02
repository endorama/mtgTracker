(function () {
  'use strict';
  // https://github.com/johnpapa/angularjs-styleguide#controllers
  
  angular
    .module('mtgTracker.collections')
    .controller('CollectionsAddCardCtrl', CollectionsAddCardCtrl);

  // CollectionsAddCardCtrl.$inject = [  ];

  /* @ngInject */
  function CollectionsAddCardCtrl (collection, $log, $flash, $state) {
    var vm = this;
    
    vm.addCard = addCard;

    //////////

    function addCard (card) {
      collection.post('cards', card)
        .then(function () {
          $flash.s('The card has been added!');
          $state.go('^.show', { id: collection.id });
        })
        .catch(function (reason) {
          $log.error(reason);
          alert('Cannot add card to collection.');
        });
    }
  };

}());
