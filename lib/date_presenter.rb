module DatePresenter
  extend ActiveSupport::Concern

  def present_date(attr_name)
    components = %w(day month year)
    components.each do |c|
      partial_name = :"#{attr_name}_#{c}"
      attr_writer partial_name
      attr_accessible partial_name

      define_method(partial_name) do
        date = self.send(attr_name)
        date && date.send(c) || self.instance_variable_get("@#{partial_name}")
      end
    end

    before_validation do
      day = self.send("#{attr_name}_day")
      month = self.send("#{attr_name}_month")
      year = self.send("#{attr_name}_year")
      if day.present? && month.present? && year.present?
        self.send("#{attr_name}=", Date.civil(year.to_i, month.to_i, day.to_i))
      end
    end
  end
end
