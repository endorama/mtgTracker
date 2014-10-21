(function () {
  'use strict';
  // https://github.com/johnpapa/angularjs-styleguide#controllers
  
  angular
    .module('mtgTracker.collections')
    .controller('CollectionsCreateCtrl', CollectionsCreateCtrl);

  // CollectionsCreateCtrl.$inject = [ '$scope', '$state', '$flash', '$log', 'CollectionsSrv' ];

  /* @ngInject */
  function CollectionsCreateCtrl ($scope, $state, $flash, $log, CollectionsSrv) {
    var vm = this;
    
    vm.create = create;
    vm.form_has_error_on = form_has_error_on;

    //////////

    function create (collection) {
      CollectionsSrv.create(collection)
        .then(function () {
          $flash.s('The collection has been created!');
          $state.go('^.index');
        })
        .catch(function (reason) {
          $log.error(reason);
          alert('Cannot create collection.');
        });
    }

    function form_has_error_on (field) {
      var field = $scope.CollectionsCreateForm[field];
      return !field.$pristine && field.$invalid;
    }

  };

}());
