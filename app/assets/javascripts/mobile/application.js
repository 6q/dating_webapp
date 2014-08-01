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
//= require_tree .

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

	$('footer #link_language').click(function(e){
		e.preventDefault();
		$('#languageBox').fadeIn(1000);
		$('.page-content').hide();
		$('footer .footer-links').hide();
	}); 

	$('footer #cancel_language').click(function(e){
		e.preventDefault();
		$('#languageBox').hide();
		$('.page-content').fadeIn(1000);
		$('footer .footer-links').fadeIn(1000);
	});	 

	$('#link_legal').click(function(e){
		e.preventDefault();
		$('#legalBox').fadeIn(1000);
		$('.page-content').hide();
		$('footer .footer-links').hide();
	}); 

	$('#cancel_legal').click(function(e){
		e.preventDefault();
		$('#legalBox').hide();
		$('.page-content').fadeIn(1000);
		$('footer .footer-links').fadeIn(1000);
	});

	/* INSIDE */

	$('#main_link').click(function(e){
		e.preventDefault();
		$('#main_box').fadeIn(1000);
		$('#languageBox').hide();
		$('#legalBox').hide();
	}); 

	$('#hidden-boxes #main_cancel').click(function(e){
		e.preventDefault();
		$('#main_box').hide();
	});

	$('#hidden-boxes #language_link').click(function(e){
		e.preventDefault();
		$('#languageBox').fadeIn(1000);
		$('#main_box').hide();
	}); 

	$('#hidden-boxes #cancel_language').click(function(e){
		e.preventDefault();
		$('#languageBox').hide();
	});	

	$('#hidden-boxes #link_legal').click(function(e){
		e.preventDefault();
		$('#legalBox').fadeIn(1000);
		$('#main_box').hide();
	}); 

	$('#hidden-boxes #cancel_legal').click(function(e){
		e.preventDefault();
		$('#legalBox').hide();
	});

	$( "#basic-tabs" ).accordion({
		heightStyle: "content",
		collapsible: true
	});
  
  $( '.swipebox' ).swipebox({
    hideBarsOnMobile : false, // false will show the caption and navbar on mobile devices
    hideBarsDelay : 10000
  });

});