define(['text!templates/course/courseitem.html'], function(template) {
  var CourseItemView = Backbone.View.extend({
    tagName: 'li',
    className: 'course-item',
    template: _.template(template),

    initialize: function() {

    },

    render: function() {
      var $el = $(this.el);
      $el.data('courseId', this.model.get('id'));
      $el.html(this.template(this.model.toJSON()));
      return this;
    }
  })

  return CourseItemView;
});