(function() {
  'use strict';
  // https://github.com/johnpapa/angularjs-styleguide#controllers
  
  angular
    .module('mtgTracker.cards')
    .controller('CardsShowCtrl', CardsShowCtrl);

  // CardsShowCtrl.$inject = [ '$scope' ];

  function CardsShowCtrl (card) {
    var vm = this;

    vm.card = card;

  };

}());
