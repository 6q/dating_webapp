$(document).ready(function(){


  // mini slider for flat pages

  jQuery.fn.exists = function(){return this.length>0;}

$(".miniSlider > li:gt(0)").fadeIn();
setInterval(function() { 
  $('.miniSlider > li:first')
    .fadeOut(1000)
    .next()
    .fadeIn(1000)
    .end()
    .appendTo('.miniSlider');
},  3000);



  // in love folding functions

  $('#in-love .fold, #in-love header').click(function(e){
    e.preventDefault();
    $('#in-love .fold').toggleClass('active');
    $('#in-love article p').slideToggle();
  });

  $('.user #in-love .fold').removeClass('active');
  //$('#in-love .fold').click();





  // image slide thing for user cards
  /*
  $(".user-card .pics").hover(function(){
    $("li:first-child", this).stop().animate({opacity:0},{queue:false,duration:500});
  }, function() {
    $("li:first-child", this).stop().animate({opacity:1},{queue:false,duration:500});
  });
  */

  $('#related-list a, .user-card').tooltip({
    html:true
  });
  $('.chat, .message, .like, .more, .block').tooltip({
    html:true
  });
});


// does not work on document.ready. Don't ask me why.
$(window).load(function() {

       var target_flexslider = $('.flexslider');

       target_flexslider.flexslider({
      		animation: "slide",
      		slideshowSpeed: 5000,
      		randomize: true,

           start: function(slider) {
               target_flexslider.removeClass('loading');
           }
    });
});    
