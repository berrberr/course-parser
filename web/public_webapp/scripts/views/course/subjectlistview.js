define(['views/course/courseitem'], function(CourseItemView) {
  var SubjectListView = Backbone.View.extend({
    el: '#course_list',
    tagName: 'ul',
    className: 'course-list',

    initialize: function() {
      this.collection = this.collection || {};
      this.collection.on('add', this.render, this);
      this.render();
    },

    render: function() {
      var $el = $(this.el);
      var self = this;

      _.each(this.collection, function(course) {
        var item;
        item = new CourseItemView({ model: course });
        $el.append(item.render().el);
      });

      return this;
    }
  });

  return SubjectListView;
});