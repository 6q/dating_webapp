$(function() {
  $(document).on('click', '.paginate-users', function(e) {
    e.preventDefault();

    section = $(this).closest('section');
    section.find('ul').replaceWith('<div style="height: 264px"><img src="/assets/ajax-loader.gif" style="margin-top: 65px; margin-left: 365px">');
    $.ajax({
      url: this.href,
      success: function(data) {
        section = $('#' + data.id)
        section.replaceWith(data.template);
        likes_bind();
        $( "[data-toggle='tooltip']" ).tooltip('disable');
      }
    });
  })
});