module NotificationConversation
  extend ActiveSupport::Concern

  included do
    after_create do |notification|
      sender = notification.sender
      recipient = notification.recipients.first
      if sender && recipient
        recipient.notifications.create({ sender_id: sender.id, notifiable_id: notification.conversation.id, notifiable_type: 'message' })
        sender.send_notification_email(:receive_message, recipient)
      end
    end
  end
end
