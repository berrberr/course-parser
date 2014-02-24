define(['models/tree/treenode'], function(TreeNode) {
  var TreeNodeView = Backbone.View.extend({
    template: _.template(
      '<div class="col-sm-12"><a href="#" class="list-group-item">Title: <%= title %></a></div>'
    ),

    childTemplate: _.template(
      '<div class="col-sm-11"><a href="#" class="list-group-item">Title: <%= title %></a></div>'
    ),

    tagName: 'div',
    parentEl: null,

    events: {
      'click': 'toggleTreeNode'
    },

    initialize: function() {
    },

    render: function() {
      $(this.el).html(this.template(this.model.toJSON()));
      return this;
    },

    toggleTreeNode: function(e) {
      event.preventDefault();
      $(this.el).append(this.childTemplate({title: "test"}));
      console.log('you clicked:', this.model.toJSON());
      console.log(e.target);
    }
  });

  return TreeNodeView;
});