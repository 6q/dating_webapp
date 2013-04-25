module ApplicationHelper

  def display_base_errors resource
    return '' if (resource.errors.empty?) or (resource.errors[:base].empty?)
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

  def pager_total(paged_object)
    html = '<span class="total">' + _('Mostrando mensajes ') + pager_total.current_page * pager_total.count - pager_total.count + 1 + _(' a ') + + pager_total.current_page * pager_total.count + _(' de ') + pager_total.total_count + '.</span>'

    html.html_safe
  end
end
