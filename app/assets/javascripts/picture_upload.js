//= require jquery
//= require jquery.iframe-transport
//= require jquery-ui
//= require jquery.Jcrop
//= require jquery.form
//= require jquery.fileupload

$(document).ready(function () {
  function showModalAndCrop(event, data) {
    var cropData;
    var modalObject;
    $("#crop_modal_wrapper").html(data.result.crop_template)
    modalObject = $("#crop_modal_wrapper #crop_modal");
    modalObject.modal({show: true});
    $("#picture_to_crop").Jcrop({
      onSelect: function (c) {
        cropData = c;
      }
    });
    $("#crop_modal .btn-primary").click(function(e) {
      e.preventDefault();
      $.post(data.result.update_path, {_method: "PUT", crop_data: cropData}, function (data) {
        modalObject.modal("hide");
        $("#picture_gallery").html(data.gallery_template);
        bindUploads(); //rebind uploads
      });
    })
  }

  function bindUploads() {
    $(".upload_pic_input").fileupload({
      dataType: 'json',
      url: '/pictures',
      formData : [{
        name : 'authenticity_token',
        value : $('meta[name="csrf-token"]').attr('content')
      }],
      acceptFileTypes: /(\.|\/)(bmp|gif|jpe?g|png)$/i,
      done: showModalAndCrop,
      change: function (e, data) {
        console.log(arguments);
      }
    });
  }

  bindUploads();

});
