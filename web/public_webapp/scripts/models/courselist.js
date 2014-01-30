define(['models/course'], function(Course) {
  var CourseList = Backbone.Collection.extend({
    model: Course
  });
  
  return CourseList;
});