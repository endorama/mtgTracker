(function () {
  'use strict';

  /**
    mtgImage[mtgImage]

    Retrieve image data from mtgimages.com
   */
  
  angular
    .module('mtgImage')
    .service('mtgImage', mtgImage);

  // mtgImage.$inject = [ ];

  /* @ngInject */
  function mtgImage () {
    var self = this;
    
    this.getSet = getSet;

    return this;

    //////////

    function getSet(setCode) {
      return 'http://mtgimage.com/symbol/set/' + setCode + '/common.svg';
    }

    
  };

}());
