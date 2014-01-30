module.exports = function (grunt) {
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    "bower-install-simple": {
      options: {
        color: true,
        production: false,
        directory: "lib"
      }
    },
    copy: {
      main: {
        files: [
          {
            nonnull: true,
            src: 'lib/backbone/backbone.js', 
            dest: 'public_webapp/scripts/vendor/backbone/backbone.js'
          },
          {
            nonnull: true,
            src: 'lib/handlebars/handlebars.js',
            dest: 'public_webapp/scripts/vendor/handlebars/handlebars.js'
          },
          {
            nonnull: true,
            src: 'lib/jquery/jquery.js',
            dest: 'public_webapp/scripts/vendor/jquery/jquery.js'
          },
          {
            nonnull: true,
            src: 'lib/underscore/underscore.js',
            dest: 'public_webapp/scripts/vendor/underscore/underscore.js'
          },
          {
            nonnull: true,
            src: 'lib/requirejs/require.js',
            dest: 'public_webapp/scripts/vendor/requirejs/require.js'
          },
          {
            nonnull: true,
            src: 'lib/requirejs-text/text.js',
            dest: 'public_webapp/scripts/vendor/requirejs/text.js'
          },
          {
            nonnull: true,
            expand: true,
            cwd: 'lib/bootstrap/dist/fonts/',
            src: ["**"],
            dest: 'public_webapp/fonts/'
          },
          {
            nonnull: true,
            expand: true,
            cwd: 'lib/bootstrap/less/',
            src: ["**"],
            dest: 'public_webapp/styles/vendor/bootstrap/'
          },
          {
            nonnull: true,
            src: 'lib/bootstrap/dist/js/bootstrap.js',
            dest: 'public_webapp/scripts/vendor/bootstrap/bootstrap.js'
          }
        ]
      }
    },
    less: {
      development: {
        options: {
          paths: ["public_webapp/styles"]
        },
        files: {
          "public_webapp/styles/main.css": "public_webapp/styles/main.less"
        }
      }
    },
    watch: {
      less: {
        files: ['public_webapp/styles/**/*.less'],
        tasks: ['less']
      }
    },  
    connect: {
      server: {
        options: {
          port: 9001,
          base: 'public_webapp'
        }
      }
    }
  });

  grunt.loadNpmTasks('grunt-bower-install-simple');
  grunt.loadNpmTasks('grunt-contrib-copy');
  grunt.loadNpmTasks('grunt-contrib-less');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-connect');
  grunt.registerTask('bower', ['bower-install-simple', 'copy']);
  grunt.registerTask('build_styles', ['less']);
  grunt.registerTask('serve', ['connect', 'watch']);

};
