module ConversationsHelper
  NAME_MAX_LENGTH = 30

  # Return a link to this subject with the name
  def link_name(subject, options = {})
    link_to subject.name, subject, options
  end

  # Return the truncated name
  def truncate_name(name, options={})
    options = {:length => NAME_MAX_LENGTH, :separator => ' '}.merge options
    h truncate(name, options)
  end
  
  def sender_or_recipient(conversation)
    user = conversation.messages.map{ |m| m.recipients }.flatten.uniq.reject{|i| i == current_user}.first
  end

  def activity_creator(activity)
    activity.conversation.recipients.reject{|u| u.id != activity.sender_id }.first
  end
end
