define(['views/course/subjectitemview'], function(SubjectItemView) {
  var SubjectListView = Backbone.View.extend({
    el: '#course_list',
    tagName: 'ul',
    className: 'course-list',

    initialize: function() {
      this.collection = this.collection || {};
      this.collection.on('add', this.render, this);
      this.render();
    },

    render: function() {
      var $el = $(this.el);
      var self = this;

      _.each(this.collection, function(subject) {
        var item;
        item = new SubjectItemView({ model: subject });
        $el.append(item.render().el);
      });

      return this;
    }
  });

  return SubjectListView;
});