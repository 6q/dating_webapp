$(function() {
  $(document).on('click', '.paginate-users', function(e) {
    e.preventDefault();

    section = $(this).closest('section');
    $.ajax({
      url: this.href,
      success: function(data) { 
        section.replaceWith(data.template);
      }
    });
  })
});
