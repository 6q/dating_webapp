module ApplicationHelper

  def display_base_errors resource
    return '' if (resource.nil?) or (resource.errors.empty?) or (resource.errors[:base].empty?)
    messages = resource.errors[:base].map { |msg| content_tag(:p, msg) }.join
    html = <<-HTML
    <div class="alert alert-error alert-block">
      <button type="button" class="close" data-dismiss="alert">&#215;</button>
      #{messages}
    </div>
    HTML
    html.html_safe
  end

  def active_if_current(url)
    current_page?(url) ? 'active' : ''
  end

  def matchmaker_user
    redirect_to(matchmaker_become_user_path) if (current_user && current_user.has_role?(:matchmaker))
  end

  def pager_total(paged_object)
    html = ""

    if paged_object.length > 0
      html = '<span class="total">' + _('Mostrando ') + "&nbsp;"
      html += (paged_object.offset_value + 1).to_s + "&nbsp;" + _(' a ') + "&nbsp;"
      html += ((paged_object.current_page * paged_object.limit_value) > paged_object.total_count ? paged_object.total_count : paged_object.current_page * paged_object.limit_value).to_s + "&nbsp;" + _(' de ') + "&nbsp;"
      html += paged_object.total_count.to_s + '.</span>'
    end

    html.html_safe
  end

  def total_users(users)
    html = ""
    if users.length > 0
      html = '<span class="total">' + _('Encontrados %{numero} perfiles') % {:numero => users.length} + '</span>'
    end
  end

  def time_ago_in_words_or_date(from_time, include_seconds_or_options = {})
    if from_time > 7.days.ago
      time_ago_in_words(from_time, include_seconds_or_options = {})
    else
      I18n.l(from_time.to_date, format: :medium)
    end
  end

  def cookies_warning
    url   = link_to _('Política de Privacidad'), privacy_policy_path
    html  = '<div class="alert alert-info alert-block"><i class="icon-remove"></i>' + _("Utilizamos cookies propias y de terceros para mejorar nuestros servicios y su experiencia. Si continua navegando, consideramos que acepta dicho uso. Puede cambiar la configuración u obtener más información en ") + url + '</div>'
    html.html_safe
  end

end