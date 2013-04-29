//= require jquery
//= require jquery.iframe-transport
//= require jquery-ui
//= require jquery.Jcrop
//= require jquery.form
//= require jquery.fileupload

$(document).ready(function(){
  $(document).on('click', 'a.upload_pic', function (event) {
    $("#upload_picture_form").show();
  });
  $("#upload_picture_files").fileupload({
    dataType: 'json',
    acceptFileTypes: /(\.|\/)(gif|jpe?g|png)$/i,
    done: function(event, data) {
      $("#picture_gallery").html(data.result.gallery_partial)
    },
    fail: function(event, data) {
    }
  });
});
