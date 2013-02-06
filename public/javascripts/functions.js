$(document).ready(function(){
	$('.flexslider').flexslider({
      animation: "slide",
      slideshowSpeed: 5000
    });

	$('#in-love .fold').click(function(e){
		e.preventDefault();
		$(this).toggleClass('active');
		$('#in-love article p').slideToggle();
	});

});