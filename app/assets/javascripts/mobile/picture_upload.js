//= require jquery
//= require jquery.iframe-transport
//= require jquery.Jcrop
//= require jquery.ui.widget.js
//= require jquery.form
//= require jquery.fileupload

$(function () {
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
    $("#crop_modal .btn").click(function(e) {
      //e.preventDefault();
      $.post(data.result.update_path, {_method: "PUT", crop_data: cropData}, function (data) {
        modalObject.modal("hide");
        $("#picture_gallery").html(data.template);
        bindUploads(); //rebind uploads
      });
    });
  }

  function bindUploads() {
    $(".upload_pic_input, .upload_pic_input_unregistered").fileupload({
      dataType: 'json',
      url: '/pictures',
      formData: [{
        name: 'authenticity_token',
        value: $('meta[name="csrf-token"]').attr('content')
      }, {name: 'main', value: $('#picture_main').val()}],
      acceptFileTypes: /(\.|\/)(jpe?g|png)$/i,
      done: function(event, data) {
        showModalAndCrop(event, data);
        $('#progress_modal').modal('hide');
        if (window.location.href.indexOf("sign_up") > -1) {}
        else window.location = '/profile';
      },
      progress: function (e, data) {
        var progress = parseInt(data.loaded / data.total * 100, 10);
        $('#progress_modal .progress .bar').css('width', progress + '%');
      },
      start: function() {
        $('#progress_modal').modal('show');
      }

    });
 }

  bindUploads();

});
