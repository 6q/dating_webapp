class MinimumAgeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return unless value
    date = options[:today] || Date.today
    minimum_age = options[:minimum_age] || 18
    unless value < (date << minimum_age * 12)
      record.errors[attribute] << (options[:message] || _("Debes ser mayor de edad."))
    end
  end
end

module MinimumAgeValidatorHelper
  def validates_minimum_age_of(attr_name, options = {})
    validates attr_name, options.merge(minimum_age: true)
  end
end
