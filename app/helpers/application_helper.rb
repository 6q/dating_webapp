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
    html = '<span class="total">' + _('Mostrando ')
    html += (paged_object.current_page * paged_object.length - paged_object.length + 1).to_s + _(' a ')
    html += (paged_object.current_page * paged_object.length).to_s + _(' de ')
    html += paged_object.total_count.to_s + '.</span>'

    html.html_safe
  end
end
