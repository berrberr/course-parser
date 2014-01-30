define([
  'models/courselist',
  'views/course/courselistview'
],

  function(CourseList, CourseListView) {
    var App = function() {
      console.log("APP FIRED");
      this.collections.courselist = new CourseList(
        [{},{},{},{}]);
      this.views.courselistview = new CourseListView({ collection: this.collections.courselist });
      console.log(this.views.courselistview);
    };

    App.prototype = {
      views: {},
      collections: {}
    };

    return App;
  });

// $(function() {
//   var app = {
//     views: {},
//     models: {},
//     router: {}
//   }

//   app.Course = Backbone.Model.extend({
//     // urlRoot: ""

//     initialize: function() {

//     },

//     defaults: {
//       "id": "1D03",
//       "name": "Intro CS 1",
//       "description": "This is the first intro class to CS.",
//       "instructor": "W. Barnes"
//     }
//   });

//   app.CourseView = Backbone.View.extend({
//     el: $('#course_list'),

//     events: {
//       'click a': 'onclick'
//     },

//     initialize: function() {
//       _.bindAll(this, 'render');

//       this.courselist = [];
//       for(var i = 0; i < 10; i++) {
//         this.courselist[i] = new app.Course();
//       }

//       this.render();
//     },

//     render: function() {
//       var self = this;
//       $(self.el).append('<ul></ul>');

//       _(this.courselist).each(function(course) {
//         $('ul', self.el).append('<li><a href="#" data-id="' + course.get('id') + '">Name: ' + course.get('name') + ' Desc: ' + course.get('description') + '</a></li>');
//       });
//     },

//     onclick: function(e) {
//       e.preventDefaults();
//       var id = $(e.currentTarget).data('id');
//       console.log(e);
//     }
//   });

//   app.AppRouter = Backbone.Router.extend({
//     routes: {
//       '': 'home'
//     },

//     home: function() {
//       return new app.CourseView();
//     }
//   });


//   new app.AppRouter();
//   Backbone.history.start();
// });