// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(function() {
	
	$(".delete-msg-btn").tooltip('disable');
	
	$(".reply-msg-btn").tooltip('disable');

  $('.message-body').keydown(function() {
    ab = $(this).closest('.modal').next('.activity-proposal').find('.activity-body')
    ab.val($(this).val());
  });

  $('.modal-new-message input[type="submit"]').click(function() {
    if ($(this).closest('.modal-new-message').find('.message-body').val().length <= 0) {
      $(this).closest('.modal-new-message').find('.message-body').css('border-color', 'red');
      return false;
    }
  });
});
