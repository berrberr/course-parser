define(function() {
  var Subject = Backbone.Model.extend({
    defaults: {

    },

    // code, name, course_list
    initialize: function(info, courselist) {
      this.course_list = courselist.where({'subject_code': info.code});
    }
  })

  return Subject;
});