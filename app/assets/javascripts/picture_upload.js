//= require jquery
//= require jquery.iframe-transport
//= require jquery-ui
//= require jquery.Jcrop
//= require jquery.form
//= require jquery.fileupload

$(function(){
  $("#upload_picture_files").fileupload({
    dataType: 'json',
    done: function(){console.log(arguments);}
  });
})
