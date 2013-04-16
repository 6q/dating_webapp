require 'date_presenter'
require 'minimum_age_validator'

class User < ActiveRecord::Base
  GENDER = ['male', 'female']
  ORIENTATION = ['heterosexual', 'homosexual', 'bisexual']
  MARITAL_STATUS = ['single', 'dating', 'engaged', 'married', 'widowed']

  extend MinimumAgeValidatorHelper
  extend DatePresenter
  present_date :birth_date

  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #virtual attributes
  attr_accessor :terms_and_conditions
  attr_accessor :image_not_uploaded
  attr_accessor :email_confirmation

  # Setup accessible (or protected) attributes for your model
  attr_accessible :role_ids, :as => :admin
  attr_accessible :name, :email, :password, :password_confirmation,
    :remember_me, :surname, :screen_name, :gender, :orientation, :marital_status,
    :birth_date, :country, :zip_code, :town, :town_id,
    :newsletter_optin, :image_not_uploaded, :email_confirmation, :terms_and_conditions

  validates_presence_of :name, :surname, :gender, :orientation, :screen_name
  validates_presence_of :email, :password
  validates_presence_of :email_confirmation, :password_confirmation
  validates_presence_of :zip_code, :town
  validates :newsletter_optin, acceptance: {accept: true}    #activerecord converts the 1 to boolean based on the column datatype
  validates :terms_and_conditions, acceptance: {accept: "1"} #it's virtual so it doesn't convert anything


  validates_minimum_age_of :birth_date, presence: true, minimum_age: true
end
