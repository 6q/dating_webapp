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

    $('.home #link_language').click(function(e){
        e.preventDefault();
        $('.home #languageBox').show();
        $('.home #loginBox').hide();
        $('.home #buttonBox').hide();
    }); 

    $('.home #cancel_language').click(function(e){
        $('.home #languageBox').hide();
        $('.home #buttonBox').show();
    });   
}); 