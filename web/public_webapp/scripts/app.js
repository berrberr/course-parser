define([
  'models/course',
  'models/courselist',
  'models/subjectlist',
  'views/course/subjectlistview',
  'views/course/coursedetailview'
],

  function(Course, CourseList, SubjectList, SubjectListView, CourseDetailView) {
    var App = function() {
      console.log("APP FIRED");
      this.collections.courselist = new CourseList(
        [{'id': 'CS201', 'description': 'This is cs201'},{'id': 'CS222'},{'id': 'CS301'},{'id': 'CS333'}]);
      this.collections.subjectlist = new SubjectList(
        [{'code': 'CS', 'name': 'Computer Science'}, {'code': 'ANTHROP', 'name': 'Anthropology'}]);
      this.views.subjectlistview = new SubjectListView({ collection: this.collections.courselist });
      this.views.coursedetailview = new CourseDetailView({ model: new Course({'id': 'Init View', 'description': 'Pick a course'}) });
    };

    App.prototype = {
      views: {},
      collections: {}
    };

    return App;
  });