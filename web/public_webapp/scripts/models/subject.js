define(function() {
  var Subject = Backbone.Model.extend({
    url: function() {
      return 'http://api.courses.dev/subject/courses/' + this.subject_code;
    },

    defaults: {
      'subject_code': 'COMP SCI',
      'name': 'Computer Science',
      'course_list': []
    },

    // code, name, course_list
    initialize: function() {
    },

    getCourseList: function() {
      var self = this;
      this.fetch({success: function(collection) {
        self.course_list = collection;
      }});
    }

  })

  return Subject;
});