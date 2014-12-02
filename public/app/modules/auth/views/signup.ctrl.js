(function () {
  'use strict';
  // https://github.com/johnpapa/angularjs-styleguide#controllers
  
  angular
    .module('mtgTracker.auth')
    .controller('SignupCtrl', SignupCtrl);

  // SignupCtrl.$inject = [  ];

  /* @ngInject */
  function SignupCtrl ($scope, AuthSrv) {
    var vm = this;

    vm.signup = signup;
    vm.has_signup_errors = has_signup_errors;
    vm.signup_errors = signup_errors;

    //////////
    var _signup_errors = null;

    function signup (formData) {
      AuthSrv.signup(formData)
        .catch(function(reason) {
          _signup_errors = reason.data.message;
        });
    }

    function has_signup_errors () {
      return !!_signup_errors;
    }

    function signup_errors () {
      return _signup_errors;
    }
  };

}());
