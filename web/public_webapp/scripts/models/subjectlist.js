define(['models/subject'], function(Subject) {
  var SubjectList = Backbone.Collection.extend({
    model: Subject,

    initialize: function() {
      this.subject_code = this.subject_code || null;
      this.course_list = window.c_app.collections.courselist.where({'subject_code': this.subject_code});
      console.log('COURSE LIST:', this.course_list);
    }
  });

  return SubjectList;
});