define(['models/course'], function(Course) {
  var CourseList = Backbone.Collection.extend({
    model: Course,
    url: 'http://api.courses.dev/course',

    initialize: function() {
      this.deferred = this.fetch();
    }
  });
  
  return CourseList;
});