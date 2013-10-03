$(document).ready(function() {
  $(document).on('click', '.notification-close', function() {
    $(this).parent().parent().fadeOut();
  });
});

function getNotifications () {
  var notification;
  $.getScript("/notifications.json")
    .done(function(notifications, textStatus) {
      notifications = JSON.parse(notifications);
      for (var i = 0; i < notifications.length; i++) {
        notification = notifications[i];
        $("body").find("#notificationTemplate").tmpl(notification).appendTo("#notifications");
        setTimeout(function() {$('[data-id='+notification.id+']').click();}, 10000);
      }
    })
  .fail(function(jqxhr, settings, exception) {
    // ERROR.
  });
  setTimeout(getNotifications, 5000);
}

