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
    
    this.calculateWidth = calculateWidth;
    this.getSet         = getSet;

    return this;

    //////////

    function calculateWidth(width) {
      switch (width) {
        case 'small':
          return 30;
          break;
        
        default:
          return 50;
      }
    }

    function getSet(setCode) {
      return 'http://mtgimage.com/symbol/set/' + setCode + '/common.svg';
    }

    
  };

}());
