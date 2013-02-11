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

	pageHeight = $('.span9 .article-body').height();
	sidebarHeight = $('aside.sidebar').height();

	logoPos = $('#in-love').offset().top - pageHeight - 57; // pageHeight - sidebarHeight - 273;

	$('aside.sidebar #sidebar-logo img').animate({ marginTop: logoPos }, 1000);
	//.css('marginTop',logoPos + 'px');

});