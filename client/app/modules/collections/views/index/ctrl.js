(function() {
  'use strict';
  // https://github.com/johnpapa/angularjs-styleguide#controllers
  
  angular
    .module('mtgTracker.collections')
    .controller('CollectionsIndexCtrl', CollectionsIndexCtrl);

  // CollectionsIndexCtrl.$inject = [  ];

  function CollectionsIndexCtrl (collections) {
    var vm = this;

    vm.collections = collections;

    vm.edit = edit_collection;
    vm.delete = delete_collection;

    //////////

    function edit_collection (coll_id) {
      console.debug(coll_id)
    };

    function delete_collection (coll_id) {
      console.debug(coll_id)
    };

  };

}());
