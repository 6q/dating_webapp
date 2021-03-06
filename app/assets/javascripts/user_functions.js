//= require jquery.slider
//= require jquery.prettyPhoto
//= require jquery.auderoFlashingText.min.js
//= require jquery.tmpl.min.js
//= require jquery.cookie.js
//= require jquery.jcarousel.min.js
//= require fancybox/jquery.fancybox-1.3.1.js

//$("#caixarandom").auderoFlashingText("stop");


function likes_bind() {
  jQuery(document).on("ajax:beforeSend", ".ajax_like_trigger", function() {
    $(".ajax_like_trigger").addClass('loading-icon');


  });

  $(".ajax_like_trigger").unbind('ajax:success').bind("ajax:success",
    function(evt, user_id, status, xhr) {
      var firstEl, secondEl;
      $(".ajax_like_trigger").removeClass('loading-icon');
      $(".user_like").addClass('hidden');
      $(".user_dislike").removeClass('hidden');

      firstEl = $('.like.active').find('[data-id=' + user_id + ']').parent();
      secondEl = $('.like.hidden').find('[data-id=' + user_id + ']').parent();

      firstEl.removeClass('disabled').removeClass('active').addClass('hidden');
      secondEl.removeClass('hidden').addClass('active');

    }
  ).unbind('ajax:error').bind("ajax:error", function(evt, data, status, xhr){
    //do something with the error here
  });

  jQuery(document).on("ajax:beforeSend", ".ajax_dislike_trigger", function() {
    $('.ajax_dislike_trigger').addClass('loading-icon');
  });

  $(".ajax_dislike_trigger").unbind('ajax:success').bind("ajax:success",
    function(evt, user_id, status, xhr) {

      var firstEl, secondEl;

      $('.ajax_dislike_trigger').removeClass('loading-icon');

      $(".user_dislike").addClass('hidden');
      $(".user_like").removeClass('hidden');


      firstEl = $('.like.hidden').find('[data-id=' + user_id + ']').parent();
      secondEl = $('.like.disabled.active').find('[data-id=' + user_id + ']').parent();

      firstEl.removeClass('hidden').addClass('active');
      secondEl.addClass('hidden').removeClass('active');

    }
  ).unbind('ajax:error').bind("ajax:error", function(evt, data, status, xhr){
    //do something with the error here
  });
}

$(document).ready(function() {
  $(".skin-change").click(function() {
    var number = $(this).data("skin");
    $.ajax({
      url: "/background.json",
      type: "post",
      data: {
        background: number
      },
      success: function(data) {
        var bg = '/assets/bg/main-bg' + data + '.jpg';
        $('header[role="banner"]').css('background','url(' + bg + ') top left no-repeat');
      }
    });
  });

  if ($("#caixarandom").length){
    if (!$("#caixarandom").auderoFlashingText("isRunning")) {
      $("#caixarandom").auderoFlashingText({
        fadeOut: 1500,
        duration: 2000,
        selection: "ascending"
      });
    }
  }

  likes_bind();

  // search sliders
  $(".points, #points2").slider({ from: 1, to: 5, round: 1, skin: "plastic" });

  $("#years").jslider({
      from: 18,
      to: 80,
      step: 1,
      smooth: true,
      round: 0,
      skin: "plastic",
      dimension: "&nbsp;",
      scale: ['|','|','|','|','|','|','|','|'],
      onstatechange: function(){
        $('#years').parent().parent().find('label span').text(' ' + $("#years").val().split(';')[0] + ' - ' + $("#years").val().split(';')[1]);
        var years = $("#years").val().split(';');
        $('#q_years_start_lteq').val(years[0]);
        $('#q_years_end_gteq').val(years[1]);
      }
    });

  $("#distance").slider({
    from: 50,
    to: 500,
    step: 10,
    round: 1,
    skin: "plastic",
    dimension: '&nbsp;kms',
    scale: ['|','|','|','|','|','|','|','|'],
    onstatechange: function(){
      $('#distance').parent().parent().find('label span').text($("#distance").val().split(';')[0] + 'kms');
    }
  });

  jQuery("#altura").slider({
    from: 150,
    to: 220,
    step: 5,
    smooth: true,
    round: 0,
    skin: "plastic",
    dimension: '&nbsp;cm',
    onstatechange: function() {
      var height = $('#altura').val().split(';');
      if (height[0] == '150' && height[1] == '220') {
        height[0] = height[1] = '';
      }
      $('#q_height_gteq').val(height[0]);
      $('#q_height_lteq').val(height[1]);
    }
  });
  $("#affinity").slider({ from: 0, to: 100, step: 5, round: 1, skin: "plastic", dimension: '&nbsp;%' });
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


  var hash = document.location.hash;
  var prefix = "tab_";
  if (hash && hash != '#_=_') {
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

  // fancybox
  $("a.grouped_elements").fancybox({
      titleShow :false
  });


});
