app.CourseView = Backbone.View.extend({
  el: $('#courselist'),

  initialize: function() {
    _.bindAll(this, 'render');

    this.courselist = [];
    for(var i = 0; i < 10; i++) {
      this.courselist[i] = new app.Course();
    }

    this.render();
  },

  render: function() {
    var self = this;
    self.el.append('<ul></ul>');

    _(this.courselist).each(function(course) {
      $('ul', self.el).append('<li>Name: ' + course.get('name') + ' Desc: ' + course.get('description') + '</li>');
    });
  }
});