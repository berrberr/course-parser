define([], function() {
  var TreeNode = Backbone.Model.extend({
    defaults: {
      title: 'Node',
      children: []
    },

    addChild: function(node) {
      this.children.push(node);
    },

    
  });

  return TreeNode;
})