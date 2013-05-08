// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(function() {
  $('#activity-types a').click(function(event) {
    event.preventDefault();

    var type = $(event.target).parent().attr('class')
    $('#activity_activity_type').val(type);
  });
});
