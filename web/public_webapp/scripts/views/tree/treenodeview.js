define(['models/tree/treenode'], function(TreeNode) {
  var TreeNodeView = Backbone.View.extend({
    template: _.template(
      '<a href="#" class="list-group-item">Title: <%= title %></a>'
    ),
    el: '#tree',

    events: {
      'click': 'toggleTreeNode'
    },

    render: function() {
      var $el = $(this.el);
      $el.append(this.template(this.model.toJSON()));
      return this;
    },

    toggleTreeNode: function(e) {
      console.log(this.model.toJSON());
    }
  });

  return TreeNodeView;
});