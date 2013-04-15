#encoding: utf-8
module RegistrationsHelper
  def gender_options
    [
      ['un chico', 'male'],
      ['una chica', 'female']
    ]
  end

  def orientation_options
    ['heterosexual', 'homosexual']
  end

  def marital_status_options
    [
      ['solter@', 'single'],
      ['viendo a alguien', 'relation'],
      ['en una relación estable', 'stable_relation'],
      ['casado@', 'married']
    ]
  end

  def country_options
    ["España"]
  end
end
