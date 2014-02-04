define(['models/subject'], function(Subject) {
  var SubjectList = Backbone.Collection.extend({
    model: Subject,
    url: 'http://api.courses.dev/subject',

    initialize: function() {
      console.log("SUBJECT COLLECTION INIT:", this);
    },

    addSubjects: function(subject_arr, courselist) {
      var self = this;
      _.each(subject_arr, function(subject) {
        self.add(new Subject(subject, courselist));
      })
    }
  });

  return SubjectList;
});