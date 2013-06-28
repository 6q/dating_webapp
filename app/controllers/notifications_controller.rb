class NotificationsController < ApplicationController
  after_filter :set_notifications_seen

  # Get all unseen notifications
  def notifications
    @notifications = CelloveNotification.where({ receiver_id: current_user.id, seen: false })
    @notificationlist = []
    @notifications.each do |notification|
      u = User.find(notification.sender_id)
      pp = u.profile_picture
      if u.profile_picture
        picture_url = pp.image.thumb.url
      else
        picture_url = "/assets/placeholder-#{u.gender}-#{Random.rand(1..3)}.jpg"
      end
      if notification.notifiable_type == 'message'
        # Create status_link
        status_link = Rails.application.routes.url_helpers.conversation_path(notification.notifiable_id)
      elsif notification.notifiable_type == 'matchmaker'
        status_link = Rails.application.routes.url_helpers.my_matchmakers_path(:anchor => "tab_confirmar")
      end
      @notificationlist.push({
        :id => notification.id, :name => u.full_name, :user_id => u.id,
        :photo => picture_url,
        :city => u.city, :age => u.age,
        :status => CelloveNotification::NOTIFICATION_TYPE[notification.notifiable_type.to_sym],
        :status_link => status_link
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
