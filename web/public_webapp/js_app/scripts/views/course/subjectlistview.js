define([
  'views/course/subjectitemview', 
  'models/subject',
  'models/course', 
  'views/course/courseitemview'], function(SubjectItemView, Subject, Course, CourseItemView) {
  var SubjectListView = Backbone.View.extend({
    el: '#course-list',
    tagName: 'div',
    className: 'list-group course-list',

    initialize: function() {
      this.collection = this.collection || {};
      this.render();
    },

    render: function(items) {
      var items = items || [];
      var $el = $(this.el);
      $el.empty();
      var self = this;

      if(items.length < 1) {
        this.collection.fetch()
          .done(function(collection, response) {
            _.each(collection, function(subject) {
              var item = new SubjectItemView({ model: new Subject(subject) });
              $el.append(item.render().el);
            });
          });
      } else {
        _.each(items, function(result) {
          var item = new CourseItemView({ model: new Course(result) });
          $el.append(item.render().el);        
        });
      }

      return this;
    }
  });

  return SubjectListView;
});