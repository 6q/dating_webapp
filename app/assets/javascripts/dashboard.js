$(function() {
  $(document).on('click', '.radius', function(e) {
    e.preventDefault();

    section = $(this).closest('section');
    partial = section.attr('id');
    radius = section.find('.radius').text();

    if (partial && radius) {
      $.ajax({
        url: "/dashboard.json",
        type: "post",
        data: {
          partial: partial,
          radius: radius
        },
        success: function(data) { 
          section.replaceWith(data.template);
        }
      });
    }
  })
});
