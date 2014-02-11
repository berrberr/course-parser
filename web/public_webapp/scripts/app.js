define([
  'models/course',
  'models/coursesearch',
  'models/subjectlist',
  'models/subject',
  'views/course/subjectlistview',
  'views/course/coursedetailview',
  'views/course/searchview'
],

  function(Course, CourseSearch, SubjectList, Subject, SubjectListView, CourseDetailView, SearchView) {
    var courses = [
    {'id': 'CS111', 'description': 'CS 111 class', 'title': 'Intro to CS 1', 'subject_code': 'CS'},
    {'id': 'CS222', 'description': 'CS 222 class', 'title': '2nd Intro to CS', 'subject_code': 'CS'},
    {'id': 'CS 3333', 'description': 'Class for CS 333', 'title': 'Data structures and algs', 'subject_code': 'CS'},

    {'id': 'ANTH1', 'description': 'Anthropology class 1', 'title': 'Intro to Anthropology', 'subject_code': 'ANTHROP'},
    {'id': 'ANTH2', 'description': 'Anthropology class 2', 'title': 'Intro to Anthropology', 'subject_code': 'ANTHROP'},
    {'id': 'ANTH3', 'description': 'Anthropology class 3', 'title': 'Intro to Anthropology', 'subject_code': 'ANTHROP'}
    ];

    var subjects = [
    {'code': 'CS', 'name': 'Computer Science'},
    {'code': 'ANTHROP', 'name': 'Anthropology'},
    {'code': 'BIO', 'name': 'Biology'}
    ];
    var App = function() {
      var self = this;

      this.collections.coursesearch = new CourseSearch();
      this.collections.subjectlist = new SubjectList();
      this.views.subjectlistview = new SubjectListView({ collection: this.collections.subjectlist });
      this.views.coursedetailview = new CourseDetailView({ model: new Course({'code': 'Init View', 'description': 'Pick a course'}) });
      this.views.searchview = new SearchView();
      // this.collections.courselist.deferred.done(function() {
      //   console.log('FETHCED: ', self.collections.courselist.toJSON());
      //   var options = {
      //     keys: ['title', 'code'],
      //     threshold: 0.4
      //   }
      //   var f = new Fuse(self.collections.courselist.toJSON(), options);
      //   var res = f.search('algorithm');
      //   console.log('SEARCH RESULTS', res);
      //   self.views.subjectlistview.render(res);
      // });
      // $.when(this.collections.courselist.search('algorithms')).done(function() {
      //   console.log(self.collections.courselist);
      //   self.views.subjectlistview.render(self.collections.courselist.toJSON());
      // });
      this.collections.coursesearch.search('algorithms', this.views.subjectlistview);


    };

    App.prototype = {
      views: {},
      collections: {}
    };

    return App;
  });