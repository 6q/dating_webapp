//= require jquery.slider.min
//= require jquery.prettyPhoto


// create slider 

function createSlider(id, min, max, value){
  $(id).slider({
    range: "max",
    min: min,
    max: max,
    value: value,
    slide: function( event, ui ) {
      //$( "#points" ).val( ui.value );
      $('.ui-slider-handle').html('<span>'+ui.value+'</span>');
      $(id).parent().find('input').val(ui.value);
    }
  });
  $('.ui-slider-handle').html('<span>'+$(id).slider( "value" )+'</span>');
  $(id).before('<div class="pull-left legend">'+min+'</div><div class="pull-right legend">'+max+'</div><div class="clearfix"></div>');
};




// document ready

$(document).ready(function(){

  // modal calls

  $('.reply a').click(function(e){
    e.preventDefault();
  });

  $('.block a').click(function(e){
  	e.preventDefault();
  });

  $('#messages-tab a').click(function (e) {
      e.preventDefault();
      $(this).tab('show');
    });

  $('#celestinos-tab a').click(function (e) {
      e.preventDefault();
      $(this).tab('show');

      if(document.location.hash == '#tab_confirmados') {
        $('.indice').slideDown('fast');
      } else {
        $('.indice').slideUp('fast');
      }
  });

  $('.celestinos header a[href="#mejora"]').click(function( e ){
    e.preventDefault();
    $('.nav-tabs a[href="#mejora"]').click();
  });


  // header switches

  $('.header-switcher .picker a').click(function(e){
    e.preventDefault();
    $(this).parent().parent().find('.leaf').toggle();
  });


$('.header-switcher .leaf a').click(function(e){
    e.preventDefault();
    $(this).parent().parent().find('.leaf').toggle();
  });

  var hash = document.location.hash;
  var prefix = "tab_";
  if (hash) {
      $('.nav-tabs a[href='+hash.replace(prefix,"")+']').tab('show');
      if(hash != '#tab_confirmados') {
        $('.indice').slideUp('fast');
      }
  } 

  // Change hash for page-reload
  $('.nav-tabs a').on('shown', function (e) {
      window.location.hash = e.target.hash.replace("#", "#" + prefix);

  });

  //$('.activity').click();


  $('.msg-reply-dialog .action-reply').click(function(e){
    e.preventDefault();
    $('.msg-reply-dialog .reply-form, .msg-reply-dialog .pic img').toggle();
  });

  $('#nice-couple li a').hover(function(){
    $(this).parent().parent().find('li a').addClass('active');
    $(this).parent().parent().find('li:gt('+$(this).parent().index()+') a').removeClass('active');
  },function(){
    $(this).parent().parent().find('li a').removeClass('active');
  });

  // image gallery in user profile

  $("a[rel^='prettyPhoto']").prettyPhoto();

});
