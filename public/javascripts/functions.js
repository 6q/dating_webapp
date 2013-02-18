$(document).ready(function(){

	jQuery.fn.exists = function(){return this.length>0;}

	jQuery.fn.slideSwitch = function () {
   	 		
		$('.miniSlider li.active').clone().appendTo('.miniSlider').removeClass('active');

		doTheSlideThing = function(){
			var $active = $('.miniSlider li.active');

    		if ( $active.length == 0 ) $active = $('.miniSlider li');

    		var $next =  $active.next().length ? $active.next()
        		: $('.miniSlider li').first();

    		$active.addClass('last-active');
        
    		$next.css({opacity: 0.0})
        		.addClass('active')
        		.animate({opacity: 1.0}, 1000, function() {
            		$active.removeClass('active last-active');
        		});
		}

       setInterval( doTheSlideThing, 5000 );

	}

	$('.miniSlider').slideSwitch();

	/*
	$('.flexslider').flexslider({
      animation: "slide",
      slideshowSpeed: 5000,
      randomize: true
    });
	*/

	$('#in-love .fold').click(function(e){
		e.preventDefault();
		$(this).toggleClass('active');
		$('#in-love article p').slideToggle();
	});

	function setSidebarLogoPosition(){

		if($('aside.sidebar ul').exists()){

			var refHeight = $('.span9 .article-body').height();
			var menuHeight = $('aside.sidebar ul').height();
			var menuPos = $('aside.sidebar ul').offset().top;

			if(refHeight > menuHeight) {
				$('aside.sidebar #sidebar-logo').height(refHeight - menuHeight + 38);	
			} else {
				$('aside.sidebar #sidebar-logo').hide();
			}

			
		}
	}

	setSidebarLogoPosition();

});

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