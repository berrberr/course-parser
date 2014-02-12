define(['models/coursesearch'], function(CourseSearch) {
  
    var SearchView = Backbone.View.extend({

      el: '#course-search',
      events: {
        'keyup': 'search'
      },

      initialize: function() {
        this.coursesearch = new CourseSearch();
        this.el_res = '#course-search-autocomplete';
      },

      search: function(e) {
        var self = this;
        var $el = $(this.el);
        if($el.val().length >= 3) {
          console.log('searching');
          this.coursesearch.setQuery($el.val());
          this.coursesearch.fetch().done(function(collection, response) {              
            $(self.el_res).empty();
            _.each(collection, function(course) {
              $(self.el_res).append('<a href="#" class="list-group-item">' + course.title + '</a>');
            });
            //window.c_app.views.subjectlistview.render(collection);
            console.log('results: ', collection);
          });
        } else {
          $(self.el_res).empty();
        }
      }
    });

  return SearchView;
});