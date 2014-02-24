define(['text!templates/course/courseitem.html', 'views/course/coursedetailview'], function(template, CourseDetailView) {
  var CourseItemView = Backbone.View.extend({
    template: _.template(template),

    events: {
      'click': 'updateCourseDetail'
    },

    initialize: function() {

    },

    render: function() {
      var $el = $(this.el);
      $el.data('courseId', this.model.get('id'));
      $el.html(this.template(this.model.toJSON()));
      return this;
    },

    updateCourseDetail: function() {
      console.log(this);
      c_app.views.coursedetailview.model.set(this.model.toJSON());
    }
  })

  return CourseItemView;
});