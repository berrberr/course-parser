$(function() {

  $('.subject-node').click(function() {
    // event.preventDefault(); //Stop scrolling to top of page
    // var showing = $(this).next('div').is(':visible');
    // hideAllCourses();
    // if(!showing) {
    //   $(this).next('div').show();
    // }
    // console.log($(this).next('div'));
  });

  function hideAllCourses() {
    $('.course-nodes').each(function(index) {
      $(this).hide();
    })
  }
});