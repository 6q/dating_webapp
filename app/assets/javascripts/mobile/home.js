$(function() {
	
    $('.home #link_login').click(function(e){
        e.preventDefault();
        $('.home #loginBox').show();
        $('.home .page-content').hide();
        $('.home footer .footer-links').hide();
    });
    
    $('.home #cancel_login').click(function(e){
        $('.home #loginBox').hide();
        $('.home .page-content').show();
        $('.home footer .footer-links').show();
    });
  
}); 