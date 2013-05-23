//= require jquery.slider
//= require jquery.prettyPhoto

$(document).ready(function(){

  // search sliders

  $(".points, #points2").slider({ from: 1, to: 5, round: 1, skin: "plastic" });

  $("#years").slider({
      from: 18,
      to: 80,
      step: 1,
      smooth: true,
      round: 0,
      skin: "plastic",
      dimension: "&nbsp;años",
      scale: ['|','|','|','|','|','|','|','|'],
      onstatechange: function(){
        // $('#years').parent().parent().find('label span').text(' entre ' + $("#years").val().split(';')[0] + ' y ' + $("#years").val().split(';')[1]);
        var years = $("#years").val().split(';');
        $('#q_years_lteq').val(years[0]);
        $('#q_years_gteq').val(years[1]);
      }
    });

  $("#kms").slider({
    from: 0,
    to: 500,
    step: 10,
    round: 1,
    skin: "plastic",
    dimension: '&nbsp;kms',
    scale: ['|','|','|','|','|','|','|','|'],
    onstatechange: function(){
      $('#kms').parent().parent().find('label span').text($("#kms").val().split(';')[0] + 'kms');
      //console.log($("#kms").val().split(';')[0]);
    }
  });

  jQuery("#altura").slider({ 
    from: 160,
    to: 220,
    step: 5,
    smooth: true,
    round: 0,
    skin: "plastic",
    dimension: '&nbsp;cm',
    onstatechange: function() {
      var height = $('#altura').val().split(';');
      $('#q_height_gteq').val(height[0]);
      $('#q_height_lteq').val(height[1]);
    }
  });
  jQuery("#afinidad").slider({ from: 0, to: 100, step: 5, round: 1, skin: "plastic", dimension: '&nbsp;%' });
  //jQuery("#points, #points2").slider({ from: 1, to: 5, step: 0.5, round: 1, skin: "plastic" });

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
