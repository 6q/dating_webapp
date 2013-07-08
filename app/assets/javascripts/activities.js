// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(function() {
  $('#activity-types a').click(function(event) {
    event.preventDefault();

    var type = $(event.target).parent().attr('class')
    $('#activity_activity_type').val(type);
    $('#activity-types a.active').animate({opacity: 0.4}, 300);
    $('#activity-types a').attr('class', '');
    $(this).attr('class', 'active');
  });

  // hover with opacity in proposal activity modal
  $('#activity-types li').mouseover(function(){
  	if ($(this).children('a').attr('class') != 'active'){
  		$(this).children().animate({opacity: 1}, 300);
  	};
  });
  $('#activity-types li').mouseout(function(){
  	if ($(this).children('a').attr('class') != 'active'){
    	$(this).children().animate({opacity: 0.4}, 300);
  	};
  });

  var dnShort = new Array("Do", "Lu", "Ma", "Mi", "Ju", "Vi", "Sa");
  var mn = new Array("Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre");

  $("#activity_date").datepicker({ 
    dateFormat: 'dd/mm/yy',
    firstDay: 1,
    dayNamesMin: dnShort,
    monthNames: mn
  });

});


