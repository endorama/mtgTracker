(function () {
  'use strict';
  // https://github.com/johnpapa/angularjs-styleguide#controllers
  
  angular
    .module('mtgTracker.collections')
    .controller('CollectionsEditCtrl', CollectionsEditCtrl);

  // CollectionsEditCtrl.$inject = [ '$scope', '$state', '$flash', '$log', 'CollectionsSrv' ];

  /* @ngInject */
  function CollectionsEditCtrl (collection, $scope, $state, $flash, $log, CollectionsSrv) {
    var vm = this;
    
    $scope.formData = angular.copy(collection);
    vm.save = save;

    //////////

    function save (formData) {
      collection.name = formData.name;
      collection.save()
        .then(function () {
          $flash.s('The collection has been updated!');
          $state.go('^.index');
        })
        .catch(function (reason) {
          $log.error(reason);
          alert('Cannot save collection.');
        });
    }

  };

}());
