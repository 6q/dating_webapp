#encoding: utf-8
module RegistrationsHelper
  def gender_options
    User::GENDER.map {|e| [t(e), e]}
  end

  def orientation_options
    User::ORIENTATION.map {|e| [t(e), e]}
  end

  def marital_status_options
    User::MARITAL_STATUS.map {|e| [t(e), e]}
  end

  def country_options
    ["España"]
  end
end
