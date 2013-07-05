class NotificationsController < ApplicationController
  after_filter :set_notifications_seen
  include UserHelper

  # Get all unseen notifications
  def notifications
    @notifications = CelloveNotification.where({ receiver_id: current_user.id, seen: false })
    @notificationlist = []
    @notifications.each do |notification|
      u = User.find(notification.sender_id)

      picture_url = profile_pic_url(u, width: 80, height: 80)

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
