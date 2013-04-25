require_dependency 'date_presenter'
require_dependency 'minimum_age_validator'
require_dependency 'user_retrieval'

class User < ActiveRecord::Base
  GENDER = ['male', 'female']
  ORIENTATION = ['heterosexual', 'homosexual', 'bisexual']
  MARITAL_STATUS = ['single', 'dating', 'engaged', 'married', 'widowed']
  PHYSICAL_DESC = ['sexy', 'ugly']
  PHYSICAL_STYLE = ['bohemian', 'urban']
  COMPLEXION = ['normal', 'athletic']
  CHILD = ['I have', 'I have not']
  CHILD_WANT = ["I don't want more", 'I want to adopt' ]
  SMOKE =['I smoke', "I don't smoke"]
  SMOKE_TOLERANCE = ['does not bother me', 'I hate it']
  DIET = ["I'm vegan", 'I eat a lot of meat']
  ALCOHOL = ['I drink alcohol', "I'm abstemious"]
  DRUGS = ['take drugs', 'do not take drugs']
  DRUGS_FREQUENCY = ['never', 'sometimes', 'always'] 
  RELIGION = ['agnostic', "I'm religious"]
  RELIGION_OPINION = ['dedicated practicant', 'non practicant']
  ANIMAL_LIKE = ['I Hate', 'I love', 'I adopt']
  ANIMAL_HAVE =["I haven't", 'I have one', 'I have many']
  STUDY_LEVEL = ['basic', 'graduate']
  LANGUAGE = ['advanced chinese', 'basic russian']
  JOB = ['technology', 'medical', 'politics']
  SALARY = ['hight', 'medium', 'low']

  PICTURE_LIMIT = 12

  extend MinimumAgeValidatorHelper
  extend DatePresenter #allows us to use birth_date_(day|month|year) attrs for setting and getting date
  include UserRetrieval

  #relations
  has_many :pictures, as: :attachable

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
  present_date :birth_date

  # Setup accessible (or protected) attributes for your model
  attr_accessible :role_ids, :as => :admin
  attr_accessible :name, :email, :password, :password_confirmation,
    :remember_me, :surname, :screen_name, :gender, :orientation, :marital_status,
    :birth_date, :country, :postal_code, :town, :town_id,
    :newsletter_optin, :image_not_uploaded, :email_confirmation, :terms_and_conditions, :physical_desc, :physical_style

  regular_user = lambda {|user| user.has_role?(:regular_user) }

  validates_presence_of :name, :surname
  validates :email, presence: true
  validates :email, confirmation: true, on: :create
  validates :password, presence: true, confirmation: true, on: :create
  validates :terms_and_conditions, acceptance: {accept: "1"} #it's virtual so it doesn't convert anything

  #Validations only performed on regular users, not matchmakers
  validates_presence_of :gender, :orientation, :screen_name, if: regular_user
  validates_presence_of :postal_code, :town, if: regular_user
  validates_presence_of :birth_date_month, :birth_date_day, :birth_date_year, if: regular_user

  validates :birth_date, presence: true, minimum_age: true, if: regular_user

  geocoded_by :location
  after_validation :geocode

  def location
    [postal_code, town, country].compact.join(', ')
  end

  def age(dob = self.birth_date)
    now = Time.now.utc.to_date
    now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
  end

  scope :popular, where('users.created_at < ?', Time.now).with_role(:user).limit(7)

  def full_name
    [name, surname].join(" ")
  end

  def profile_picture
    self.pictures.where("main is true").limit(1).first || self.pictures.limit(1).first
  end

end
