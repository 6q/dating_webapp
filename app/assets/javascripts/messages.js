// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(function() {

  $('.message-body').keydown(function() {
    ab = $(this).closest('.modal').next('.activity-proposal').find('.activity-body')
    ab.val($(this).val());
  });
});
