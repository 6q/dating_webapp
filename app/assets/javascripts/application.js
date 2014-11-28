// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require functions
//= require jquery.flexslider-min
//= require jquery.datepicker.min
//= require user_functions
//= require chosen.jquery.min
//= require rails.validations
//= require ajax-chosen.min
//= require activities
//= require ajax-chosen
//= require cities
//= require conversations
//= require cycle
//= require dashboard
//= require flat_pages
//= require functions
//= require home
//= require invitations
//= require jquery.raty
//= require letsrate
//= require lightbox
//= require messages
//= require notifications
//= require picture_upload
//= require rails.validations
//= require recommendations
//= require searches
//= require social_networks
//= require user_functions







$(function() {
  // hide flash messages afer 3 seconds
  if ($('#flash-messages').length){
    setTimeout(function() {
      left = ($(window).width()/2)-($('#flash-messages').width()/2);
      $('#flash-messages').css('left', left+'px');
      $('#flash-messages').fadeIn('slow').delay(3000).fadeOut('slow');
    }, 500);

  }

  $('.icon-remove').click(function() {
    $(this).parent().hide(500);
    return false;
  });

});
$(document).ready(parpadear);
function parpadear(){ 
  $('nav ul li span').fadeIn(500).delay(2000).fadeOut(500, parpadear);
  $('#main-sidebar ul li span').fadeIn(500).delay(2000).fadeOut(500, parpadear);
}