(function () {
  'use strict';

  /**
    mtgTracker.auth[AuthSrv]

    Proxy Satellizer $auth to provide informations about user session
    status.
   */
  
  angular
    .module('mtgTracker.auth')
    .service('AuthSrv', AuthSrv);

  // AuthSrv.$inject = [ ];

  /* @ngInject */
  function AuthSrv ($log, $auth, $q, Api) {

    this.current_user = current_user;
    this.isAuthenticated = $auth.isAuthenticated;
    this.login = login;
    this.signup= signup;
    this.logout = logout;

    //////////
    var _current_user;

    function current_user () {
      if (!_current_user) {
        return Api.oneUrl('auth/user').get()
          .then(function(result) {
            _current_user = result.data;
            return result;
          });
      }

      return $q.when(_current_user);
    }

    function login (data) {
      $log.info('Login', data);
      return $auth.login(data)
        .then(function(result) {
          _current_user = result.data.data;
        })
        .catch(function(reason) {
          $log.error('Login error', reason);
        });
    }
    
    function logout () {
      $log.info('Logout')
      return $auth.logout();
    }

    function signup (data) {
      $log.info('Signup', data);
      return $auth.signup(data)
        .then(function() {
          _current_user = result.data.data;
          // $flash('SignUp successful! Please login with your new credentials!');
        })
        .catch(function(reason) {
          $log.error('Signup error', reason);
        });
    }
 
    return this;

  };

}());
