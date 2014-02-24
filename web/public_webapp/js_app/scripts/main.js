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
    'vendor/fusejs/fuse': {
      exports: 'Fuse'
    },
    'app': {
      deps: ['vendor/underscore/underscore', 'vendor/backbone/backbone', 'vendor/fusejs/fuse']
    }
  }
});

require([
  'app'
],

function(App) {
  window.c_app = new App();
});