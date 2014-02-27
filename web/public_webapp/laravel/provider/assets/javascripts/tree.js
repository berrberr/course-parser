$(function() {

  $('.subject-node').click(function() {
    $(this).next('div').toggle();
    console.log($(this).next('div'));
  });
});