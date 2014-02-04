define(['text!templates/course/subjectitem.html', 'models/course', 'views/course/courseitem'], function(template, Course, CourseItemView) {
  var SubjectItemView = Backbone.View.extend({
    tagName: 'li',
    className: 'subject-item',
    template: _.template(template),

    events: {
      'click': 'showSubjectCourses'
    },

    initialize: function() {
    },

    render: function() {
      var $el = $(this.el);
      $el.html(this.template(this.model.toJSON()));
      return this;
    },

    //On clicking this treenode show the subnode (the course list)
    //Add a sibling div containing a ul with each li being a courseitemview
    showSubjectCourses: function() {
      //console.log(this.model);
      var $el = $(this.el);
      $el.after('<div id="course_leaf"><ul></ul></div>');
      $el = $('#course_leaf');
      this.model.fetch()
        .done(function(collection, response) {
          _.each(collection, function(course) {
            var item = new CourseItemView({ model: new Course(course) });
            $el.append(item.render().el);
          });
        });
    }
  })

  return SubjectItemView;
});