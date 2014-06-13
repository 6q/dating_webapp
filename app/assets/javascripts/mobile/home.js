$(function() {
    $('.home #link_login').click(function(e){
        e.preventDefault();
        $('.home #loginBox').show();
        $('.home #buttonBox').hide();
    });
    
    $('.home #cancel_login').click(function(e){
        $('.home #loginBox').hide();
        $('.home #buttonBox').show();
    });
}); 