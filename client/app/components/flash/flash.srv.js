(function () {
  'use strict';

  /**
    mtgTracker.flash[$flash]

    This service handles flash message display and queue
   */
  
  angular
    .module('mtgTracker.flash')
    .provider('$flash', $flash);

  // $flash.$inject = [ ];

  /* @ngInject */
  function $flash () {
    var defaults = {
      // How long to wait before removing the flash message.
      duration: 5000,
      // The type of message.
      type: 'alert',
      // Flash messages will not persist across route change events unless
      // explicitly specified the route change event to bind to
      routeChangeSuccess: '$stateChangeSuccess'
    };

    // update defaults
    this.options = function (opts) {
      opts = opts || {};
      defaults = angular.extend(defaults, opts);
    };

    // return the proper service    
    this.$get = function($rootScope, $timeout) {
      var $flash;

      // add a message to the queue
      $flash = flashAdder;
      $flash.current = flashCurrentMessage;
      // messages queue
      $flash.messages = [];
      // empty the message queue
      $flash.reset = flashReset;

      // quick methods
      $flash.d = flashAddDanger;
      $flash.i = flashAddInfo;
      $flash.s = flashAddSuccess;
      $flash.w = flashAddWarning;

      $rootScope.$on(defaults.routeChangeSuccess,
        function() {
          _current_message = $flash.messages.shift() || false;
        });

      //////////
      var _current_message;
      
      function flashAdder (message, opts) {
        opts = opts || {};

        $flash.messages.push({
          message: message,
          options: angular.extend(defaults, opts)
        });
      }

      function flashCurrentMessage () {
        return _current_message;
      }

      function flashReset () {
        $flash.messages.length = 0;
      }

      function flashAddDanger (msg, opts) {
        opts = opts || {};
        opts.type = 'danger';
        flashAdder(msg, opts);
      } 
      function flashAddInfo (msg, opts) {
        opts = opts || {};
        opts.type = 'info';
        flashAdder(msg, opts);
      } 
      function flashAddSuccess (msg, opts) {
        opts = opts || {};
        opts.type = 'success';
        flashAdder(msg, opts);
      } 
      function flashAddWarning (msg, opts) {
        opts = opts || {};
        opts.type = 'warning';
        flashAdder(msg, opts);
      } 


      return $flash;

    };

    return this;
  };

}());
