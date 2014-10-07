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
    vm.form_has_error_on = form_has_error_on;
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

    function form_has_error_on (field) {
      var field = $scope.SignupForm[field];
      return !field.$pristine && field.$invalid;
    };

    function has_signup_errors () {
      return !!_signup_errors;
    }

    function signup_errors () {
      return _signup_errors;
    }
  };

}());
