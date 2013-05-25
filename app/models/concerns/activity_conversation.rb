module ActivityConversation
  extend ActiveSupport::Concern

  included do
    has_one :activity
    after_commit do |conversation|
      m = Message.where(conversation_id: conversation.id).first
      sender = conversation.messages.first.sender
      recipient = m.recipients.where("id != ?", sender.id).first
      recipient.notifications.create({ sender_id: sender.id, notifiable_id: conversation.id, notifiable_type: 'message' })
    end
  end
end
