define(['models/course'], function(Course) {
  var CourseList = Backbone.Collection.extend({
    model: Course,
    url: 'http://api.courses.dev/course',

    initialize: function() {
      var self = this;
      this.ready = false;
      this.fetch()
        .done(function(collection) {
          console.log('FETCH: ', collection);
          self.collection = collection;
          self.ready = true;
        });
    }
  });
  
  return CourseList;
});