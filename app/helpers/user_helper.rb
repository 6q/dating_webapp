#encoding: utf-8
module UserHelper
  def profile_pic(user = current_user, options = {width: 210})
    pp = user.profile_picture
    if user.profile_picture
      size = "#{options[:width]}x#{options[:height]}"
      image_tag(pp.image.thumb(size).url)
    else
      image_tag("placeholder-#{user.gender}-#{Random.rand(1..3)}.jpg")
    end
  end

  def online?(user)
    #TODO: Implement
    rand > 0.5000
  end

  def user_action_links
    html = '<li class="message">' + link_to('Send Message', '#fast-reply', 'data-toggle' => 'modal') + '</li>'
    html += '<li class="chat">' + link_to('Chat', '/user/chat/') + '</li>'
    html += '<li class="like">' + link_to('Like', '/user/likes-of-mine/') + '</li>'
    html += '<li class="block">' + link_to('Block', '#user-block', 'data-toggle' => 'modal') + '</li>'
    html.html_safe
  end

  def user_remaining_pictures(user = current_user)
    User::PICTURE_LIMIT - user.pictures.count
  end

  def user_detail(user)
    html = '<div class="user-detail clearfix">'
    html += '<div class="pic">' + link_to(image_tag('placeholder2.jpg', size: '60x60'), user) + '</div>'
    html += '<div class="data">' + link_to(user.name, user) + ', ' + n_('Años', 'Años', user.age) + ' - ' +  user.town + '</div>'
    html += '</div>'

    html.html_safe
  end
end
