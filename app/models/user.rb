# encoding: utf-8

require_dependency 'date_presenter'
require_dependency 'minimum_age_validator'
require_dependency 'user_retrieval'

class User < ActiveRecord::Base
  GENDER = {'male' => _('Hombre'), 'female' => _('Mujer')}
  ORIENTATION = {'heterosexual' => _('heterosexual'), 'homosexual' => _('homosexual'), 'bisexual' => _('bisexual')}
  MARITAL_STATUS = {'single' => _('solter@'),'engaged' => _('ocupad@'), 'separated' => _('separad@'), 'divorced' => _('divorciad@'),
    'married' => _('casad@'), 'widowed' => _('viud@')}
  CHILD = { 'have-children' => _('tengo hijos'),'no-children' => _('no tengo hijos'),'no-want-children' => _('no tengo hijos, y no quiero tener'),
    'no-kids-i-want' => _('no tengo hijos, pero quiero tener'),'have-children-no-want-more' => _('si tengo hijos, y no quiero tener mas '),
    'have-children-want-more' => _('si tengo hijos, y quiero tener mas '),'no-like-kids' => _('no me gustan los niños')}
  HOUSE = {'alone' => _('sol@'),'couple' => _('en pareja'),'with-kids' => _('con mis hijos'),
    'occasionally-with-children' => _('ocasionalmente con mis hijos'),'accompanied' => _('acompañad@')}
  PHYSICAL_DESC = {'normal' => _('normal'), 'sexy' => _('atractiv@'), 'pretty' => _('guap@'), 'of-the-mill' => _('del montón')}
  PHYSICAL_STYLE = {'bohemian' => _('bohemio'), 'classic' => _('clásico'),'indie/casual' => _('indie/casual'),
    'sport' => _('deportivo'),'formal' => _('formal'), 'trendy' => _('a la moda'),'rocker' => _('rockero'), 'preppy' => _('pijo')}
  EYES = {'brown' => _('marrón'),'black' => _('negro'),'green' => _('verde'),'gray' => _('gris'),'coffee' => _('café'),'blue' => _('azul')}
  HAIR = {'blond' => _('rubio'),'redhead' => _('pelirrojo'),'gray' => _('gris'),'brown' => _('marrón'),'black' => _('negro')}
  HAIR_STYLE = {'short' => _('corto'),'very short' => _('muy corto'),'large' => _('largo'),'shaved' => _('afeitado'),
    'hairless' => _('sin pelo')}
  COMPLEXION = {'thin' => _('delgado'), 'normal' => _('normal'), 'nice' => _('muy bien'), 'athletic' => _('atlético'), 'strong' => _('fuerte'), 
    'curvy' => _('con curvas'), 'obese' => _('obeso')}
  SMOKE = {'smoker' => 'fumo', 'non-smoker' => 'no fumo', 'smoker-hater' => 'soy antitabaco','not-mind-smoke' => _('no me molesta el humo'),
    'smoke-leave-couple' => _('fumo pero lo dejaría por mi pareja'), 'social-smoker' => _('soy fumador social')}
  RELIGION = {'agnostic' => _('agnóstico'), 'atheist' => _('ateo'), 'christian' => _('cristiano'), 'jewish' => _('judío'), 
    'catholic' => _('católico'), 'muslim' => _('musulmán'), 'hindu' => _('indú'), 'buddhist' => _('budista')}
  ETHNICITY = {'hispanic' => _('hispano'), 'arab' => _('árabe'), 'indian' => _('indio'), 'european' => _('europeo'), 
    'african' => _('africano'), 'asian' => _('asiático') }
  STUDY_LEVEL = {'school' => _('instituto o inferior'), 'high-school' => _('bachillerato'),'certified' => _('diplomado'), 
    'professional' => _('módulo profesional'), 'graduate' => _('licenciado o superior')}
  JOB = {'artistic' => _('trabajos artísticos y creativos '),'banking' => _('banca, financiero'),'administrative' => _('adminsitrativo'),
    'technology' => _('ordenadores y tecnología'),'construction' => _('construcción'),'education' => _('educación'),
    'advertising' => _('publicidad, entretenimiento y medios'),'management' => _('ejecutivo y gestión '),'health'=> _('salud'),
    'travel' => _('viajes'),'legal' => _('servicios legales'),'military' => _('militar'),'employee' => _('empleado'),
    'public-employee' => _('empleado público / gobierno'),'science' => _('ciencia'), 'sales' => _('ventas y márketing'),
    'transportation' => _('transporte y logística '),'unemployed' => _('desempleado'),'retired' => _('jubilado'),
    'retired-temporarily' => _('retirado temporalmente'),'studying' => _('estoy estudiando')}
  DIET = {'vegetarian' => _('vegetariana'), 'vegan' => _('vegana'), 'japanese' => _('japonesa'), 'mediterranean' => _('mediterránea'),
    'italian' => _('italiana'), 'kosher' => _('kosher'), 'halal' => _('halal'), 'obsessive-food' => _('soy muy maniátic@ con la comida'),
    'like-all' => _('me gusta todo'), 'adapt' => _('me adapto fácilmente')}
  ALCOHOL = {'when-go-out' => _('Me gusta beber solo cuando salgo'), 'not-drink' => _('no bebo alcohol'),
    'occasionally' => _('bebo ocasionalmente'), 'drinker' => _('soy bebedor'), 'meke-me-sick' => _('el alcohol no me sienta bien')}
  WEDDING_OPINION = {'would-marry' => _('Me gustaría casarme'), 'would-not-marry' => _('no me gustaría casarme'), 
    'not-believe' => _('no creo en el matrimonio'), 'married-no-repeat'=> _('ya he estado casado y no quiero repetir'),
    'married-repeat' => _('ya he estado casado y quiero repetir'), 'wonderful' => _('el matrimonio es algo maravilloso')}
  RELIGION_ACTIVITY = {'essential' => _('Para mi la religión es esencial en mi vida'),
    'care-little' => _('me importa poco la religión'), 'not-care' => _('no me importa en absoluto la religión')}
  ANIMALS = {'like-pets' => _('Me gustan los animales de compañía'), 'not-like-pets' => _('no me gustan los animales de compañía'),
    'have-pets' => _('tengo animales de compañía'), 'no-pets' => _('no tengo animales de compañía'),
    'allergic' => _('no tengo animales de compañía y soy alérgico')}
  PARTY = {'like-out' => _('Me gusta mucho salir'), 'not-like-out' => _('no me gusta salir'), 'like-bars' => _('me gusta ir de bares'),
    'like-disco' => _('me gusta ir a la discoteca'), 'like-drink-friends' => _('me gusta ir a tomar algo con amigos'),
    'love-party' => _('me encanta la fiesta'), 'not-like-party' => _('no me gusta nada la fiesta')}
  MUSIC = {'like-music' => _('Me gusta la música'), 'no-like-music' => _('no me gusta la música')}
  MUSIC_GENRE = {'pop' => _('pop'), 'rock' => _('rock'), 'classical' => _('clásica'), 'opera' => _('ópera'), 'heavy' => _('heavy'),
    'everything' => _('de todo un poco')}
  CINEMA = {'like-cinema' => _('Me gusta ir al cine'), 'not-like-cinema' => _('no me gusta ir al cine')}
  CINEMA_FREQUENCY = {'occasionally' => _('solo ocasionalemnete'), 'often' => _('muy a menudo')}
  CINEMA_GENRE = {'romantic' => _('románticas'), 'dramas' => _('dramas'), 'comedies' => _('comedias'), 'police' => _('policíacas'),
    'terror' => _('terror')}

  LF_CHILD = {'having' => _('tengo'), 'not having' => _('no tengo')}
  LF_CHILD_WANT = {'no-more' => _('no quiero más'), 'adopt' => _('quiero adoptar')}
  LF_SMOKE = {'smoker' => _('fumador'), 'non-smoker' => _('no fumador')}
  LF_SMOKE_TOLERANCE = {'bothers' => _('no me importa'), 'hate the smoke' => _('odio el humo')}
  LF_DIET = {'vegan' => _('vegan'), 'meat-eater' => _('meat-eater')}
  LF_ALCOHOL = {'alcohol-drinker' => _('bebo alcohol'), 'abstemious' => _('abstemio')}
  LF_DRUGS = {'take-drugs' => _('tome drogas'), 'not-take-drugs' => _('no tome drogas')}
  LF_ANIMAL_LIKE = {'hate' => _('odio'), 'love' => _('me gustan'), 'adopte' => _('adopto')}
  LF_ANIMAL_HAVE = {'one' => _('uno'), 'not-having' => _('no tengo'), 'many' => _('muchos')}


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

