module DatePresenter
  def present_date(attr_name)
    %w(day month year).each do |f|
      partial_name = :"#{attr_name}_#{f}"
      attr_writer partial_name
      attr_accessible partial_name

      define_method(partial_name) do
        date = self[attr_name]
        date.send(f) if date
      end
    end
  end
end
