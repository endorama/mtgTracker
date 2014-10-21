(function() {
  'use strict';
  // https://github.com/johnpapa/angularjs-styleguide#controllers
  
  angular
    .module('mtgTracker.collections')
    .controller('CollectionsIndexCtrl', CollectionsIndexCtrl);

  // CollectionsIndexCtrl.$inject = [  ];

  function CollectionsIndexCtrl (collections, $flash, $state) {
    var vm = this;

    vm.collections = collections;

    vm.edit = edit_collection;
    vm.delete = delete_collection;

    //////////

    function edit_collection (coll_id) {
      console.debug(coll_id)
    };

    function delete_collection (collection) {
      var doConfirm = confirm('Confirm collection deletion?')
      if (doConfirm) {
        collection.remove()
          .then(function () {
            $flash.s('The collection has been deleted!');
            $state.forceReload();
          });
      }
    };

  };

}());
