#encoding: utf-8
module UserHelper
  def profile_pic(user = current_user, options = {width: 210})
    pp = user.profile_picture
    if user.profile_picture
      size = "#{options[:width]}x#{options[:height]}"
      image_tag(pp.image.thumb(size).url)
    else
      image_tag("placeholder-user.jpg")
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
    if !user.has_role(:regular_user)
      return ""
    end
    html = '<div class="user-detail clearfix">'
    html += '<div class="pic">' + link_to(image_tag('placeholder2.jpg', size: '60x60'), user) + '</div>'
    html += '<div class="data">' + link_to(user.name, user) + ', ' + n_('Años', 'Años', user.age) + ' - ' 
    html += user.town if user.town
    html += '</div>'
    html += '</div>'

    html.html_safe
  end

  def rating_for(rateable_obj, options={})
    star = options[:star] || 5
    disable_after_rate = options[:disable_after_rate] || false
    readonly = false
    if disable_after_rate
      readonly = current_user.present? ? !rateable_obj.can_rate?(current_user.id) : true
    end

    content_tag :div, '', :class => "star",
                "data-rating" => current_user.rating(rateable_obj.id),
                "data-id" => rateable_obj.id,
                "data-classname" => rateable_obj.class.name,
                "data-disable-after-rate" => disable_after_rate,
                "data-readonly" => readonly,
                "data-star-count" => star
  end
end
