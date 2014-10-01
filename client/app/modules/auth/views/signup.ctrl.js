(function () {
  'use strict';
  // https://github.com/johnpapa/angularjs-styleguide#controllers
  
  angular
    .module('mtgTracker.auth')
    .controller('SignupCtrl', SignupCtrl);

  // SignupCtrl.$inject = [  ];

  /* @ngInject */
  function SignupCtrl ($auth) {
    var vm = this;
    

    vm.signup = signup;

    //////////

    function signup (formData) {
      $auth.signup(formData);
    }
  };

}());
