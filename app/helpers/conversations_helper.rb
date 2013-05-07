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
  
  def sender(conversation)
    user = conversation.messages.map{ |m| m.sender }.uniq.reject{|i| i == current_user}.first
  end
end
