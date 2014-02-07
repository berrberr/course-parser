define(['text!templates/course/subjectitem.html', 'models/course', 'views/course/courseitemview'], function(template, Course, CourseItemView) {
  var SubjectItemView = Backbone.View.extend({
    template: _.template(template),

    events: {
      'click': 'toggleSubjectCourses'
    },

    initialize: function() {
      this.visible = false;
    },

    render: function() {
      var $el = $(this.el);
      $el.html(this.template(this.model.toJSON()));
      return this;
    },

    //On clicking this treenode show the subnode (the course list)
    //Add a sibling div containing a ul with each li being a courseitemview
    toggleSubjectCourses: function() {
      //console.log(this.model);
      event.preventDefault();
      var $el = $(this.el);
      $('.subtree-row').remove();
      if(this.visible) {
        this.visible = false;
      } else {
        $el.after('<div class="row subtree-row" id="subtree-row"><div class="col-sm-11 subtree"><div id="course-leaf"></div></div></div>');
        $el = $('#course-leaf');
        this.model.fetch()
          .done(function(collection, response) {
            _.each(collection, function(course) {
              var item = new CourseItemView({ model: new Course(course) });
              $el.append(item.render().el);
            });
          });
        this.visible = true;
      }
    }
  })

  return SubjectItemView;
});