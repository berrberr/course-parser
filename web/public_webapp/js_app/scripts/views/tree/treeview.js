define(['views/tree/treenodeview'], function(TreeNodeView) {
  var TreeView = Backbone.View.extend({
    
    el: '#tree',

    render: function() {
      console.log(this);
      this.collection.each(function(node) {
        var treeNodeView = new TreeNodeView({ model: node });
        this.$el.append(treeNodeView.render().el);
      }, this);

      return this;
    }
  });

  return TreeView;
});