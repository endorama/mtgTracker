(function () {
  'use strict';
  // https://github.com/johnpapa/angularjs-styleguide#controllers
  
  angular
    .module('mtgTracker.auth')
    .controller('LoginCtrl', LoginCtrl);

  // LoginCtrl.$inject = [  ];

  /* @ngInject */
  function LoginCtrl ($scope, AuthSrv) {
    var vm = this;

    vm.login = login;    
    vm.has_login_errors = has_login_errors;
    vm.login_errors = login_errors;

    //////////
    var _login_errors = null;

    function login (formData) {
      AuthSrv.login(formData)
        .catch(function(reason) {
          _login_errors = reason.data.message;
        });
    };

    function has_login_errors () {
      return !!_login_errors;
    }

    function login_errors () {
      return _login_errors;
    }
  };

}());
