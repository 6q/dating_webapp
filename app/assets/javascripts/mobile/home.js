$(function() {
	
    $('.home #link_login').click(function(e){
        e.preventDefault();
        $('.home #loginBox').fadeIn(1000);
        $('.home .page-content').hide();
        $('.home footer .footer-links').hide();
    });
    
    $('.home #cancel_login').click(function(e){
        $('.home #loginBox').hide();
        $('.home .page-content').fadeIn(1000);
        $('.home footer .footer-links').fadeIn(1000);
    });
  
}); 