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
      e.preventDefault();
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
      acceptFileTypes: /(\.|\/)(bmp|gif|jpe?g|png)$/i,
      done: showModalAndCrop,
      progressall: function (e, data) {
        var progress = parseInt(data.loaded / data.total * 100, 10);
        $('.progress .bar').css('width', data.loaded);
      },
      start: function() {
        var modalObject;
        $("#crop_modal_wrapper").html('<div id="crop_modal" class="modal hide fade" tabindex="-1" role="dialog"><div class="modal-body"><div class="progress progress-striped active"><div class="bar"></div></div></div></div>');
        modalObject = $("#crop_modal_wrapper #crop_modal");
        modalObject.modal({show: true});
      }

    });
 }

  bindUploads();

});
