// Karma configuration

// https://jasmine.github.io/1.3/introduction.html
// https://www.npmjs.org/package/karma-fixtures-preprocessor

// http://andyshora.com/unit-testing-best-practices-angularjs.html
// https://github.com/vojtajina/ng-directive-testing
// https://github.com/velesin/jasmine-jquery


module.exports = function(config){
  config.set({

    basePath : '../',

    files : [
      'app/bower_components/angular/angular.js',
      'app/bower_components/angular-route/angular-route.js',
      'app/bower_components/angular-mocks/angular-mocks.js',
      'app/js/**/*.js',
      'test/unit/specHelpers.js'
      'test/unit/**/*.js'
    ],

    autoWatch : true,

    frameworks: ['jasmine'],

    // start these browsers
    // available browser launchers: https://npmjs.org/browse/keyword/karma-launcher
    browsers: [ 'PhantomJS' ],

    plugins : [
            'karma-chrome-launcher',
            'karma-firefox-launcher',
            'karma-jasmine',
            'karma-junit-reporter'
            ],

    // preprocess matching files before serving them to the browser
    // available preprocessors: https://npmjs.org/browse/keyword/karma-preprocessor
    preprocessors: {
      'modules/**/*.html': 'ng-html2js'
    },

    // test results reporter to use
    // possible values: 'dots', 'progress'
    // available reporters: https://npmjs.org/browse/keyword/karma-reporter
    reporters: ['dots'],

    junitReporter : {
      outputFile: 'test_out/unit.xml',
      suite: 'unit'
    }

  });
};
