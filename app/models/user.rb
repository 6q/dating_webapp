require_dependency 'date_presenter'
require_dependency 'minimum_age_validator'
require_dependency 'user_retrieval'

class User < ActiveRecord::Base
  GENDER = {'male' => _('Hombre'), 'female' => _('Mujer')}
  ORIENTATION = ['heterosexual', 'homosexual', 'bisexual']
  MARITAL_STATUS = ['single', 'dating', 'engaged', 'married', 'widowed']
  CHILD = ['I have children','I have no children','no children I have, and I do not have',
    'I have no children, but I want','I have children, and do not want more',
    'I have children, and want to have more','I do not like children']
  HOUSE = ['alone','a couple','with my kids','occasionally with my children','accompanied']
  PHYSICAL_DESC = ['normal', 'sexy', 'pretty', 'run of the mill']
  PHYSICAL_STYLE = ['bohemian', 'classic','indie/casual','sport','formal','trendy','rocker']
  EYES = ['brown','black','green','gray','coffee','blue']
  HAIR = ['blond','redhead','gray','brown','black']
  HAIR_STYLE = ['short','very short','large','shaved','hairless']
  COMPLEXION = ['thin', 'normal', 'nice', 'athletic', 'strong', 'curvy', 'obese']
  SMOKE =[ 'I smoke',"I don't smoke",'I hate smoke','I do not mind the smoke',
    'I smoke but I would leave for my couple',"I'm a social smoker"]
  RELIGION = ['agnostic', 'atheist', 'christian', 'jewish', 'catholic', 'muslim', 'hindu', 'buddhist']
  ETHNICITY = ['Hispanic', 'Arab', 'Indian', 'European', 'African', 'Asian']
  STUDY_LEVEL = ['school or less', 'high school','certified', 'professional module', 'graduate or higher']
  JOB = ['artistic and creative jobs','banking, financial','administrative','computers and technology',
    'construction','education','advertising, entertainment and media','executive and management',
    'health','travel','legal services','military','employee','public employee / government','science',
    'sales and marketing','transportation and Logistics','unemployed','retired','retired temporarily','I am studying']
  DIET = ['vegetarian', 'vegan', 'japanese', 'mediterranean', 'italian', 'kosher', 'halal',
    "I'm very obsessive with food",'I like everything', 'I adapt easily']
  ALCOHOL = ['I like to drink only when I go out', 'do not drink', 'I drink occasionally', 
    "I'm drinking", 'alcohol makes me sick']
  WEDDING_OPINION = ['I would marry', 'I would not marry', 'I do not believe in marriage',
    "I've been married and do not want to repeat", "I've been married and I want to repeat", 'marriage is a wonderful thing']
  RELIGION_ACTIVITY = ['For me religion is essential in my life', 'I care little about religion', 'I do not care at all religion']
  ANIMALS = ['I like pets', 'I do not like pets', 'I have pets', 'I have no pets', 'I have no pets and am allergic']
  PARTY = ['I like going out', 'I not like to go out', 'I like to go to bars', 'I like going to the disco', 
    'I like to go for a drink with friends', 'I love to party', 'I do not like the party']
  MUSIC = ['I like music', "I don't like music"]
  MUSIC_GENRE = ['pop', 'rock', 'classical', 'opera', 'heavy', 'a bit of everything']
  CINEMA = ['I like going to the cinema', 'do not like going to the cinema']
  CINEMA_FREQUENCY = ['only occasionally', 'often']
  CINEMA_GENRE = ['romantic', 'dramas', 'comedies', 'police', 'terror']

  LF_CHILD = ['Having', 'Not having']
  LF_CHILD_WANT = ['not want to have more', 'want to adopt']
  LF_SMOKE = ['smoker', 'non-smoker']
  LF_SMOKE_TOLERANCE = ['bothers', 'hate the smoke']
  LF_DIET = ['strict vegan', 'no control meat eater']
  LF_ALCOHOL = ['alcohol drinker', 'abstemious']
  LF_DRUGS = ['take drugs', 'do not take drugs']
  LF_ANIMAL_LIKE = ['hate', 'love', 'adopte']
  LF_ANIMAL_HAVE = ['having one', 'not having', 'having many']


  PICTURE_LIMIT = 12

  extend MinimumAgeValidatorHelper
  extend DatePresenter #allows us to use birth_date_(day|month|year) attrs for setting and getting date
  include UserRetrieval

  #relations
  has_many :pictures, as: :attachable
  has_many :characteristics
  has_one :my_characteristics, class_name: 'Characteristic', conditions: Proc.new { "creator_id = #{self.id}" }

  accepts_nested_attributes_for :characteristics

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
    :newsletter_optin, :image_not_uploaded, :email_confirmation, :terms_and_conditions, 
    :physical_desc, :physical_style, :height, :weight, :complexion, :child, :child_want, 
    :smoke, :smoke_tolerance, :diet, :alcohol, :drugs, :drug_frequency, :religion, 
    :religion_opinion, :animal_like, :animal_have, :study_level, :language, :job, :salary, 
    :description, :hobbies, :party, :music, :cinema, :lf_gender, :lf_orientation, 
    :lf_marital_status, :lf_age_between, :lf_age_to, :lf_city, :lf_country, :lf_postal_code,
    :lf_physical_desc, :lf_physical_style, :lf_height_between, :lf_weight_to, :lf_weight_between,
    :lf_complexion, :lf_child, :lf_child_want, :lf_smoke, :lf_smoke_tolerance, :lf_diet, 
    :lf_alcohol, :lf_drugs, :lf_drug_frequency, :lf_religion, :lf_religion_opinion, 
    :lf_animal_like, :lf_animal_have, :lf_study_level, :lf_language, :lf_job, :lf_salary,
    :characteristics_attributes

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

  def is_over_picture_limit?
    self.pictures.count >= PICTURE_LIMIT
  end

end

