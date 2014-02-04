define([
  'models/course',
  'models/courselist',
  'models/subjectlist',
  'models/subject',
  'views/course/subjectlistview',
  'views/course/coursedetailview'
],

  function(Course, CourseList, SubjectList, Subject, SubjectListView, CourseDetailView) {
    var courses = [
    {'id': 'CS111', 'description': 'CS 111 class', 'name': 'Intro to CS 1', 'subject_code': 'CS'},
    {'id': 'CS222', 'description': 'CS 222 class', 'name': '2nd Intro to CS', 'subject_code': 'CS'},
    {'id': 'CS 3333', 'description': 'Class for CS 333', 'name': 'Data structures and algs', 'subject_code': 'CS'},

    {'id': 'ANTH1', 'description': 'Anthropology class 1', 'name': 'Intro to Anthropology', 'subject_code': 'ANTHROP'},
    {'id': 'ANTH2', 'description': 'Anthropology class 2', 'name': 'Intro to Anthropology', 'subject_code': 'ANTHROP'},
    {'id': 'ANTH3', 'description': 'Anthropology class 3', 'name': 'Intro to Anthropology', 'subject_code': 'ANTHROP'}
    ];

    var subjects = [
    {'code': 'CS', 'name': 'Computer Science'},
    {'code': 'ANTHROP', 'name': 'Anthropology'},
    {'code': 'BIO', 'name': 'Biology'}
    ];
    var App = function() {
      this.collections.courselist = new CourseList(courses);
      this.collections.subjectlist = new SubjectList();
      // this.collections.subjectlist.fetch({success: function() {
      //   console.log("CALLBACK:", this.collections.subjectlist);
      // }});
      this.views.subjectlistview = new SubjectListView({ collection: this.collections.subjectlist });
      this.views.coursedetailview = new CourseDetailView({ model: new Course({'id': 'Init View', 'description': 'Pick a course'}) });
    };

    App.prototype = {
      views: {},
      collections: {}
    };

    return App;
  });