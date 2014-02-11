define(['models/coursesearch'], function(CourseSearch) {
  
    var SearchView = Backbone.View.extend({

      el: '#course-search',
      events: {
        'keyup': 'search'
      },

      initialize: function() {
        this.coursesearch = new CourseSearch();
      },

      search: function(e) {
        var $el = $(this.el);
        if($el.val().length >= 3) {
          console.log('searching');
          this.coursesearch.setQuery($el.val());
          this.coursesearch.fetch().done(function(collection, response) {

            console.log('results: ', collection);
          });
        }
      }
    });

  return SearchView;
});