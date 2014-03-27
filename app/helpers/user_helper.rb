#encoding: utf-8
module UserHelper
  def profile_pic_url(user, options)
    size = "#{options[:width]}x#{options[:height]}#"
    anonymous = options[:invisible]
    url = nil
    if !anonymous && profile_pic = user.profile_picture
      url = profile_pic.image.thumb(size).url
    else
      app = Dragonfly[:images]
      uid = app.store(Pathname.new(Rails.application.config.assets.paths.first + "/placeholder-#{user.gender || 'male'}-#{Random.rand(1..3)}.jpg"))
      image = app.fetch(uid)
      url = image.thumb(size).url
    end

    url
  end

  def profile_pic(user = current_user, options = {width: 210, height: 210, invisible: false})
    image_tag(profile_pic_url(user, options))
  end

  def user_action_links
    html = '<li class="message">' + link_to(_('Enviar Mensaje'), '#fast-reply', 'data-toggle' => 'modal', title: _('Enviar Mensaje')) + '</li>'
    html += '<li class="chat">' + link_to('Chat', '/user/chat/', title: 'Chat') + '</li>'
    html += '<li class="like">' + link_to(_('Me gusta'), '/user/likes-of-mine/', title: _('Me gusta')) + '</li>'
    html += '<li class="block">' + link_to(_('Bloquear'), '#user-block', 'data-toggle' => 'modal', title: _('Bloquear')) + '</li>'
    html.html_safe
  end

  def user_remaining_pictures(user = current_user)
    User::PICTURE_LIMIT - user.pictures.count
  end

  def user_detail(user)
    if !user.has_role?(:regular_user)
      return ""
    end
    html = '<div class="user-detail clearfix">'
    html += user_link_with_picture(user)
    html += "<div class=\"data\">#{link_to(user.name, user)}, #{user.age} Años - #{user.city}</div>"
    html += '</div>'

    html.html_safe
  end

  def user_link_with_picture(user)
    html = '<div class="pic">' + link_to(profile_pic(user, width: 60, height: 60), user) + '</div>'
    html.html_safe
  end

  def rating_for(rateable_obj, rater_obj = nil, options = {})
    star = options[:star] || 5
    disable_after_rate = options[:disable_after_rate] || false
    readonly = options[:read_only] || false
    if disable_after_rate
      readonly = current_user.present? ? !rateable_obj.can_rate?(current_user.id) : true
    end

    rating = current_user.rating(rateable_obj.id)
    if !rater_obj.nil?
      rating = rater_obj.rating(rateable_obj.id)
    end

    content_tag :div, '', :class => "star",
                "data-rating" => rating,
                "data-id" => rateable_obj.id,
                "data-classname" => rateable_obj.class.name,
                "data-disable-after-rate" => disable_after_rate,
                "data-readonly" => readonly,
                "data-star-count" => star
  end

  def stars_for(rateable_obj, rater_obj = nil)
    rating = current_user.rating(rateable_obj.id).to_i
    if !rater_obj.nil?
      rating = rater_obj.rating(rateable_obj.id).to_i
    end
    if rating != 0
      html = '<span class="stars stars-'+rating.to_s+'">'
      rating.times{ html += '*' }
      html += '</span>'
    elsif rateable_obj == current_user
      html = '&nbsp;' + _('Pendiente')
    else
      html = '&nbsp;' + link_to(_('Puntuar'), rateable_obj)
    end
    html.html_safe
  end

  def indicate(count)
    if count > 0
      html = "<span>#{count}</span>"
    else
      html = ""
    end

    html.html_safe
  end
end
