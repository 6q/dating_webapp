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

  def user_detail(conversation)
    html = '<div class="user-detail clearfix">'
    html += '<div class="pic">' + link_to(image_tag('placeholder2.jpg', size: '60x60'), user_path(sender(conversation))) + '</div>'
    html += '<div class="data">' + link_to(sender(conversation).name, sender(conversation)) + '</div>'
    html += '</div>'

    html.html_safe
  end
end
