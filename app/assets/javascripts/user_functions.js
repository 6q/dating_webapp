//= require jquery.slider
//= require jquery.prettyPhoto
//= require jquery.auderoFlashingText.min.js
//= require jquery.tmpl.min.js
//= require jquery.cookie.js
//= require jquery.jcarousel.min.js

$(document).ready(function() {
  setTimeout(getNotifications, 60000);

  function getNotifications () {
    var notification;
    $.getScript("/notifications.json")
    .done(function(notifications, textStatus) {
      notifications = JSON.parse(notifications);
      for (var i = 0; i < notifications.length; i++) {
        notification = notifications[i];
        $("body").find("#notificationTemplate").tmpl(notification).appendTo("#notifications");
      }
    })
    .fail(function(jqxhr, settings, exception) {
      // ERROR.
    });
    setTimeout(getNotifications, 60000);
  }

  $(document).on('click', '.notification-close', function() {
    $(this).parent().parent().remove();
  });

  var hasSkin = $.cookie("cellove-skin");
  if (hasSkin) {
    var bg = '/assets/bg/main-bg' + hasSkin + '.jpg';
    $('header[role="banner"]').css('background','url(' + bg + ') top left no-repeat');
  } else {
    $.getScript("/background.json").done(function(background, textStatus) { });
  }

  $(".skin-change").click(function() {
    var number = $(this).data("skin"),
        bg = '/assets/bg/main-bg' + number + '.jpg';
    $('header[role="banner"]').css('background','url(' + bg + ') top left no-repeat');
    $.cookie("cellove-skin", number);
    $.ajax({
      url: "/background.json",
      dataType: "jsonp",
      type: "post",
      data: {
        background: number
      },
      success: function(data) { }
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

  $(".ajax_like_trigger").bind("ajax:success",
    function(evt, data, status, xhr) {
      $(".user_like").addClass('hidden');
      $(".user_dislike").removeClass('hidden');
    }
  ).bind("ajax:error", function(evt, data, status, xhr){
    //do something with the error here
    $("div#errors p").text(data);
  });
  $(".ajax_dislike_trigger").bind("ajax:success",
    function(evt, data, status, xhr) {
      $(".user_dislike").addClass('hidden');
      $(".user_like").removeClass('hidden');
    }
  ).bind("ajax:error", function(evt, data, status, xhr){
    //do something with the error here
    $("div#errors p").text(data);
  });

  // search sliders

  $(".points, #points2").slider({ from: 1, to: 5, round: 1, skin: "plastic" });

  $("#years").jslider({
      from: 18,
      to: 80,
      step: 1,
      smooth: true,
      round: 0,
      skin: "plastic",
      dimension: "&nbsp;años",
      scale: ['|','|','|','|','|','|','|','|'],
      onstatechange: function(){
        $('#years').parent().parent().find('label span').text(' entre ' + $("#years").val().split(';')[0] + ' y ' + $("#years").val().split(';')[1]);
        var years = $("#years").val().split(';');
        $('#q_years_end_lteq').val(years[0]);
        $('#q_years_start_gteq').val(years[1]);
      }
    });

  $("#distance").slider({
    from: 0,
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
