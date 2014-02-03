define(['text!templates/course/subjectitem.html'], function(template) {
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
    showSubjectCourses: function() {
      console.log(this);
    }
  })

  return SubjectItemView;
});