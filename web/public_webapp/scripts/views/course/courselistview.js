define(['views/course/courseitem'], function(CourseItemView) {
  var CourseListView = Backbone.View.extend({
    el: '#course_list',
    tagName: 'ul',
    className: 'course-list',

    initialize: function() {
      window.console.log("INIT FIRED");
      this.collection = this.collection || {};
      this.collection.on('add', this.render, this);
    },

    render: function() {
      window.console.log("START REDNERING");
      var $el = $(this.el);
      var self = this;

      this.collection.each(function(course) {
        var item;
        item = new CourseItemView({ model: course });
        $el.append(item.render().el);
      });

      return this;
    }
  });

  return CourseListView;
});