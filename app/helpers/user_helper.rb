#encoding: utf-8
module UserHelper
  def profile_pic(user = current_user, options = {width: 210, height: 210})
    pp = user.profile_picture
    size = "#{options[:width]}x#{options[:height]}#"
    if user.profile_picture
      image_tag(pp.image.thumb(size).url)
    else
      app = Dragonfly[:images]
      uid = app.store(Pathname.new(Rails.application.config.assets.paths.first + "/placeholder-#{user.gender || 'male'}-#{Random.rand(1..3)}.jpg"))
      image = app.fetch(uid)
      image_tag(image.thumb(size).url)
    end
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
    if !user.has_role?(:regular_user)
      return ""
    end
    html = '<div class="user-detail clearfix">'
    html += user_link_with_picture(user) 
    html += '<div class="data">' + link_to(user.name, user) + ', ' + n_('Años', 'Años', user.age) + ' - ' +  user.town + '</div>'
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
    html = '<span class="stars stars-'+rating.to_s+'">'
    rating.times{ html += '*' }
    html += '</span>'
    html.html_safe
  end
end
