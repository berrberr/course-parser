define(['views/course/subjectitemview', 'models/subject'], function(SubjectItemView, Subject) {
  var SubjectListView = Backbone.View.extend({
    el: '#course_list',
    tagName: 'ul',
    className: 'course-list',

    initialize: function() {
      this.collection = this.collection || {};
      this.render();
    },

    render: function() {
      var $el = $(this.el);
      var self = this;

      this.collection.fetch()
        .done(function(collection, response) {
          _.each(collection, function(subject) {
            var item = new SubjectItemView({ model: new Subject(subject) });
            $el.append(item.render().el);
          });
        });

      // _.each(this.collection, function(subject) {
      //   var item;
      //   item = new SubjectItemView({ model: subject });
      //   $el.append(item.render().el);
      // });

      return this;
    }
  });

  return SubjectListView;
});