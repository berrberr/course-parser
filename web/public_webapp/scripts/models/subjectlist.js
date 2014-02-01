define(['models/subject'], function(Subject) {
  var SubjectList = Backbone.Collection.extend({
    model: Subject
  });

  return SubjectList;
});