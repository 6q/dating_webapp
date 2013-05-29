module NotificationConversation
  extend ActiveSupport::Concern

  included do
    after_create do |notification|
      conversation = Conversation.find(notification.conversation_id)
      m = Message.where(conversation_id: conversation.id).first
      sender = conversation.messages.first.sender
      recipient = conversation.messages.map{ |m| m.recipients }.flatten.uniq.reject{|i| i == sender}.first
      if sender && recipient
        recipient.notifications.create({ sender_id: sender.id, notifiable_id: conversation.id, notifiable_type: 'message' })
        sender.send_notification_email(:receive_message, recipient)
      end
    end
  end
end
