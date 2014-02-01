define(['views/course/subjectlistview'], function(SubjectListView) {
  var SubjectTreeView = new Backbone.View.extend({

    el: '#subject_tree',

    initialize: function() {
      this.collection = this.collection || {};
      this.collection.on('add', this.render, this);
      this.render();
    },

    render: function() {

    }
  });

  return SubjectTreeView;
})