define(['text!templates/course/coursedetail.html'], function(template) {
  var CourseDetailView = Backbone.View.extend({
    el: '#course-details',
    template: _.template(template),

    initialize: function() {
      this.model.on('change', this.render, this);
      this.render();
    },

    render: function() {
      console.log("MODEL JSON: ", this.model.toJSON());
      var $el = $(this.el);
      $el.html(this.template(this.model.toJSON()));
      return this;
    }
  })

  return CourseDetailView;
});