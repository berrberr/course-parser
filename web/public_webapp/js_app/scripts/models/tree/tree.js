define(['models/tree/treenode'], function(TreeNode) {
  var Tree = Backbone.Collection.extend({
    model: TreeNode
  });

  return Tree;
});