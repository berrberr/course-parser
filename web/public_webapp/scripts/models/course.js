define(function() {
  var Course = Backbone.Model.extend({
    defaults: {
      'id': 'CS 101',
      'name': 'CS Intro 1',
      'description': 'This is cs intro 1'
    }
  });

  return Course;
});
// (function($) {
//   var app = window.app || {};
  
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

//   app.CourseCollection = Backbone.Collection.extend({
//     model: app.Course

//     //url: "api/course/list/"
//   })
// })(jQuery);