//= require jquery
//= require jquery.iframe-transport
//= require jquery.Jcrop
//= require jquery.ui.widget.js
//= require jquery.form
//= require jquery.fileupload

$(document).ready(function () {
  function showModalAndCrop(event, data) {
    var cropData;
    var modalObject;
    $("#crop_modal_wrapper").html(data.result.crop_template);
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
    });
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

    // Not sure if this works in browsers other than Chrome.
    $('.upload_pic_input_unregistered').change(function(evt) {
      var files = evt.target.files,
          reader = new FileReader(),
          cropData;

      reader.onload = (function(theFile){
        return function(e) {
          $("#renderImage").html('<img id="crop_profile_img" src="' + e.target.result + '" />');
        };
      })(files[0]);
      reader.readAsDataURL(files[0]);
    });
  }

  bindUploads();

});
