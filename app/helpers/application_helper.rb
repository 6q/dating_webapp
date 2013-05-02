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
    html = '<span class="total">' + _('Mostrando mensajes ') + (paged_object.current_page * paged_object.count - paged_object.count + 1).to_s + _(' a ') + (paged_object.current_page * paged_object.count).to_s + _(' de ') + paged_object.total_count.to_s + '.</span>'

    html.html_safe
  end
end
