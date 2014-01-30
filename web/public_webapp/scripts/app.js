define([
  'models/course',
  'models/courselist',
  'views/course/courselistview',
  'views/course/coursedetailview'
],

  function(Course, CourseList, CourseListView, CourseDetailView) {
    var App = function() {
      console.log("APP FIRED");
      this.collections.courselist = new CourseList(
        [{'id': 'CS201', 'description': 'This is cs201'},{'id': 'CS222'},{'id': 'CS301'},{'id': 'CS333'}]);
      this.views.courselistview = new CourseListView({ collection: this.collections.courselist });
      this.views.coursedetailview = new CourseDetailView({ model: new Course({'id': 'Init View', 'description': 'Pick a course'}) });
    };

    App.prototype = {
      views: {},
      collections: {}
    };

    return App;
  });