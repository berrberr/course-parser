define(['models/course'], function(Course) {
  var CourseList = Backbone.Collection.extend({
    model: Course,
    url: function() {
      return 'http://api.courses.dev/course/search/' + this.query;
    },

    initialize: function() {
      //this.deferred = this.fetch();
    },

    search: function(query, view) {
      view = view || null;
      this.query = query;
      this.fetch()
        .done(function(collection, response) {
           this.results = collection;
           if(view !== null) view.render(collection);
           console.log('SEARCH: ', view);
        });
    }
  });
  
  return CourseList;
});