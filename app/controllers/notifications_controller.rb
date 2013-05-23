class NotificationsController < ApplicationController
  after_filter :set_notifications_seen

  # Get all unseen notifications
  def notifications
    @notifications = CelloveNotification.where({ receiver_id: current_user.id, seen: false })
    @notificationlist = []
    @notifications.each do |notification|
      u = User.find(notification.sender_id)
      @notificationlist.push({
        :id => notification.id, :name => u.full_name, :user_id => u.id,
        :photo => "/assets/placeholder2.jpg", #u.profile_picture.image.thumb("80x80").url,
        :town => u.town, :age => u.age,
        :status => CelloveNotification::NOTIFICATION_TYPE[notification.notifiable_type.to_sym]
      })
    end

    json = @notificationlist.to_json
    respond_to do |format|
      format.html
      format.json { render json: json }
    end
  end

  private
    def set_notifications_seen
      @notifications.each do |notification|
        notification.seen = true
        notification.save
      end
    end
end
