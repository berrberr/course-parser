requirejs.config({
  baseUrl: 'scripts',

  paths: {
    text: 'vendor/requirejs/text'
  },

  shim: {
    'vendor/underscore/underscore': {
      exports: '_'
    },
    'vendor/backbone/backbone': {
      deps: ['vendor/underscore/underscore'],
      exports: 'Backbone'
    },
    'app': {
      deps: ['vendor/underscore/underscore', 'vendor/backbone/backbone']
    }
  }
});

require([
  'app'
],

function(App) {
  window.c_app = new App();
});