=begin
ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  object = instance.object
  attr_name = instance.method_name
  errors = instance.object.errors.messages[attr_name.to_sym]
  out = %{<span class="field_with_errors">#{html_tag}
    <ul class="error_messages" style="display: none">
  }
  errors.each do |e|
    out += "<li>#{e}</li>"
  end
  out += %{
    </ul>
    </span>
  }
  out.html_safe
end
=end
