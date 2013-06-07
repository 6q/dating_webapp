# encoding: utf-8
# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string(255)
#  surname                :string(255)
#  screen_name            :string(255)
#  gender                 :string(255)
#  orientation            :string(255)
#  marital_status         :string(255)
#  birth_date             :date
#  postal_code            :string(255)
#  town                   :string(255)
#  country                :string(255)
#  newsletter_optin       :boolean
#  latitude               :float
#  longitude              :float
#  physical_style         :string(255)
#  physical_desc          :string(255)
#  height                 :decimal
#  weight                 :decimal
#  complexion             :string(255)
#  child                  :string(255)
#  smoke                  :string(255)
#  diet                   :string(255)
#  alcohol                :string(255)
#  religion               :string(255)
#  animals                :string(255)
#  study_level            :string(255)
#  language               :string(255)
#  job                    :string(255)
#  salary                 :string(255)
#  description            :string(255)
#  party                  :text
#  music                  :text
#  cinema                 :text
#  lf_gender              :string(255)
#  lf_orientation         :string(255)
#  lf_marital_status      :string(255)
#  lf_age_between         :string(255)
#  lf_age_to              :string(255)
#  lf_city                :string(255)
#  lf_country             :string(255)
#  lf_postal_code         :string(255)
#  lf_physical_style      :string(255)
#  lf_physical_desc       :string(255)
#  lf_height_between      :integer
#  lf_height_to           :integer
#  lf_weight_between      :integer
#  lf_weight_to           :integer
#  lf_complexion          :string(255)
#  lf_child               :string(255)
#  lf_smoke               :string(255)
#  lf_diet                :string(255)
#  lf_alcohol             :string(255)
#  lf_religion            :string(255)
#  lf_study_level         :string(255)
#  lf_language            :string(255)
#  lf_job                 :string(255)
#  lf_salary              :string(255)
#  lf_description         :string(255)
#  house                  :string(255)
#  eyes                   :string(255)
#  hair                   :string(255)
#  hair_style             :string(255)
#  citizenship            :string(255)
#  ethnicity              :string(255)
#  language_level         :string(255)
#  wedding_opinion        :string(255)
#  music_genre            :string(255)
#  cinema_frequency       :string(255)
#  cinema_genre           :string(255)
#  like_sport             :string(255)
#  like_read              :string(255)
#  like_cinema            :string(255)
#  like_quiet             :string(255)
#  like_walk              :string(255)
#  like_mountain          :string(255)
#  like_beach             :string(255)
#  like_family            :string(255)
#  like_friends           :string(255)
#  religion_activity      :string(255)
#  invitation_code        :string(255)
#  lf_house               :string(255)
#  lf_hair                :string(255)
#  lf_hair_style          :string(255)
#  lf_eyes                :string(255)
#  lf_like_sport          :string(255)
#  lf_like_read           :string(255)
#  lf_like_cinema         :string(255)
#  lf_like_quiet          :string(255)
#  lf_like_walk           :string(255)
#  lf_like_mountain       :string(255)
#  lf_like_beach          :string(255)
#  lf_like_family         :string(255)
#  lf_like_friends        :string(255)
#  lf_religion_activity   :string(255)
#  lf_citizenship         :string(255)
#  lf_ethnicity           :string(255)
#  lf_animals             :string(255)
#  lf_party               :string(255)
#  lf_language_level      :string(255)
#  cellove_index          :integer          default(0)
#



require_dependency 'date_presenter'
require_dependency 'minimum_age_validator'
require_dependency 'user_retrieval'

class User < ActiveRecord::Base
  GENDER = {'male' => _('hombre'), 'female' => _('mujer')}
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
  SMOKE = {'smoker' => 'Fumo', 'non-smoker' => 'No fumo', 'smoker-hater' => 'Soy antitabaco','not-mind-smoke' => _('No me molesta el humo'),
    'smoke-leave-couple' => _('Fumo pero lo dejaría por mi pareja'), 'social-smoker' => _('Soy fumador social')}
  RELIGION = {'agnostic' => _('agnóstico'), 'atheist' => _('ateo'), 'christian' => _('cristiano'), 'jewish' => _('judío'), 
    'catholic' => _('católico'), 'muslim' => _('musulmán'), 'hindu' => _('indú'), 'buddhist' => _('budista')}
  ETHNICITY = {'hispanic' => _('hispana'), 'arab' => _('árabe'), 'indian' => _('india'), 'european' => _('europea'), 
    'african' => _('africana'), 'asian' => _('asiática') }
  STUDY_LEVEL = {'school' => _('instituto o inferior'), 'high-school' => _('bachillerato'),'certified' => _('diplomado'), 
    'professional' => _('módulo profesional'), 'graduate' => _('licenciado o superior')}
  LANGUAGE = { 'english' => _('Inglés'), 'spanish' => _('Español'), 'french' => _('Francés'), 'italian' => _('Italiano'), 'other' => _('otro') }
  LANGUAGE_LEVEL = { 'low' => _('bajo'), 'medium' => _('medio'), 'hight' => _('alto') }
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
  ALCOHOL = {'when-go-out' => _('me gusta beber solo cuando salgo'), 'not-drink' => _('no bebo alcohol'),
    'occasionally' => _('bebo ocasionalmente'), 'drinker' => _('soy bebedor'), 'meke-me-sick' => _('el alcohol no me sienta bien')}
  WEDDING_OPINION = {'would-marry' => _('Me gustaría casarme'), 'would-not-marry' => _('No me gustaría casarme'), 
    'not-believe' => _('No creo en el matrimonio'), 'married-no-repeat'=> _('Ya he estado casado y no quiero repetir'),
    'married-repeat' => _('Ya he estado casado y quiero repetir'), 'wonderful' => _('El matrimonio es algo maravilloso')}
  RELIGION_ACTIVITY = {'essential' => _('para mi la religión es esencial en mi vida'),
    'care-little' => _('me importa poco la religión'), 'not-care' => _('no me importa en absoluto la religión')}
  ANIMALS = {'like-pets' => _('Me gustan los animales de compañía'), 'not-like-pets' => _('No me gustan los animales de compañía'),
    'have-pets' => _('Tengo animales de compañía'), 'no-pets' => _('No tengo animales de compañía'),
    'allergic' => _('No tengo animales de compañía y soy alérgico')}
  PARTY = {'like-out' => _('Me gusta mucho salir'), 'not-like-out' => _('No me gusta salir'), 'like-bars' => _('Me gusta ir de bares'),
    'like-disco' => _('Me gusta ir a la discoteca'), 'like-drink-friends' => _('Me gusta ir a tomar algo con amigos'),
    'love-party' => _('Me encanta la fiesta'), 'not-like-party' => _('No me gusta nada la fiesta')}
  MUSIC = {'like-music' => _('Me gusta la música'), 'no-like-music' => _('no me gusta la música')}
  MUSIC_GENRE = {'pop' => _('pop'), 'rock' => _('rock'), 'classical' => _('clásica'), 'opera' => _('ópera'), 'heavy' => _('heavy'),
    'everything' => _('de todo un poco')}
  CINEMA = {'like-cinema' => _('Me gusta ir al cine'), 'not-like-cinema' => _('No me gusta ir al cine')}
  CINEMA_FREQUENCY = {'occasionally' => _('ocasionalemnete'), 'often' => _('muy a menudo')}
  CINEMA_GENRE = {'romantic' => _('romántico'), 'dramas' => _('drama'), 'comedies' => _('comedia'), 'police' => _('policíaco'),
    'terror' => _('terror')}


  # LOOKING FOR OPTIONS
  LF_RELATIONSHIP = {'friends' => _('hacer nuevas amistades'), 'fun' => _('salir y pasarlo bien'), 
    'couple' => _('establecer una relación estable'), 'marry' => _('casarme')}
  LF_HOUSE = {'alone' => _('sol@'),'couple' => _('en pareja'),'with-kids' => _('con sus hijos'),
    'occasionally-with-children' => _('ocasionalmente con sus hijos'),'accompanied' => _('acompañad@')}
  LF_SMOKE = {'smoker' => 'fume', 'non-smoker' => 'no fume', 'smoker-hater' => 'sea antitabaco','not-mind-smoke' => _('no le moleste el humo'),
    'smoke-leave-couple' => _('fume pero lo dejaría por su pareja'), 'social-smoker' => _('sea fumador social')}
  LF_ALCOHOL = {'when-go-out' => _('le guste beber solo cuando salga'), 'not-drink' => _('no beba alcohol'),
    'occasionally' => _('beba ocasionalmente'), 'drinker' => _('sea bebedor'), 'meke-me-sick' => _('el alcohol no le sienta bien')}
  LF_PARTY = {'like-out' => _('le guste mucho salir'), 'not-like-out' => _('no le guste salir'), 'like-bars' => _('le guste ir de bares'),
    'like-disco' => _('le guste ir a la discoteca'), 'like-drink-friends' => _('le guste ir a tomar algo con amigos'),
    'love-party' => _('le encante la fiesta'), 'not-like-party' => _('no le guste nada la fiesta')}
  LF_DIET = {'vegetarian' => _('vegetariana'), 'vegan' => _('vegana'), 'japanese' => _('japonesa'), 'mediterranean' => _('mediterránea'),
    'italian' => _('italiana'), 'kosher' => _('kosher'), 'halal' => _('halal'), 'obsessive-food' => _('sea muy maniátic@ con la comida'),
    'like-all' => _('le guste todo'), 'adapt' => _('se adapte fácilmente')}
  LF_RELIGION_ACTIVITY = {'essential' => _('la religión sea esencial en su vida'),
    'care-little' => _('le importe poco la religión'), 'not-care' => _('no le importe en absoluto la religión')}
  LF_ANIMALS = {'like-pets' => _('le gusten los animales de compañía'), 'not-like-pets' => _('no le gusten los animales de compañía'),
    'have-pets' => _('tenga animales de compañía'), 'no-pets' => _('no tenga animales de compañía'),
    'allergic' => _('no tenga animales de compañía y sea alérgic@')}
  LF_CHILD = { 'have-children' => _('tenga hijos'),'no-children' => _('no tenga hijos'),'no-want-children' => _('no tenga hijos, y no quiera tener'),
    'no-kids-i-want' => _('no tenga hijos, pero quiera tener'),'have-children-no-want-more' => _('tenga hijos, y no quiera tener mas '),
    'have-children-want-more' => _('tenga hijos, y quiera tener mas '),'no-like-kids' => _('no le gusten los niños')}

  # THIRD PERSON OPTIONS
  TP_CHILD = { 'have-children' => _('tiene hijos'),'no-children' => _('no tiene hijos'),'no-want-children' => _('no tiene hijos, y no quiere tener'),
    'no-kids-i-want' => _('no tiene hijos, pero quiere tener'),'have-children-no-want-more' => _('tiene hijos, y no quiere tener mas '),
    'have-children-want-more' => _('si tiene hijos, y quiere tener mas '),'no-like-kids' => _('no le gustan los niños')}
  TP_HOUSE = {'alone' => _('sol@'),'couple' => _('en pareja'),'with-kids' => _('con sus hijos'),
    'occasionally-with-children' => _('ocasionalmente con sus hijos'),'accompanied' => _('acompañad@')}
  TP_SMOKE = {'smoker' => 'fuma', 'non-smoker' => 'no fuma', 'smoker-hater' => 'es antitabaco','not-mind-smoke' => _('no le molesta el humo'),
    'smoke-leave-couple' => _('fuma pero lo dejaría por su pareja'), 'social-smoker' => _('es fumador social')}
  TP_DIET = {'vegetarian' => _('vegetariana'), 'vegan' => _('vegana'), 'japanese' => _('japonesa'), 'mediterranean' => _('mediterránea'),
    'italian' => _('italiana'), 'kosher' => _('kosher'), 'halal' => _('halal'), 'obsessive-food' => _('es muy maniátic@ con la comida'),
    'like-all' => _('le gusta todo'), 'adapt' => _('se adapta fácilmente')}
  TP_ALCOHOL = {'when-go-out' => _('le gusta beber solo cuando sale'), 'not-drink' => _('no bebe alcohol'),
    'occasionally' => _('bebe ocasionalmente'), 'drinker' => _('es bebedor'), 'meke-me-sick' => _('el alcohol no le sienta bien')}
  TP_WEDDING_OPINION = {'would-marry' => _('le gustaría casarse'), 'would-not-marry' => _('no le gustaría casarse'), 
    'not-believe' => _('no cree en el matrimonio'), 'married-no-repeat'=> _('ya ha estado casad@ y no quiere repetir'),
    'married-repeat' => _('ya ha estado casad@ y quiere repetir'), 'wonderful' => _('el matrimonio es algo maravilloso')}
  TP_RELIGION_ACTIVITY = {'essential' => _('la religión es esencial en su vida'),
    'care-little' => _('le importa poco la religión'), 'not-care' => _('no le importa en absoluto la religión')}
  TP_ANIMALS = {'like-pets' => _('le gustan los animales de compañía'), 'not-like-pets' => _('mo le gustan los animales de compañía'),
    'have-pets' => _('tiene animales de compañía'), 'no-pets' => _('no tiene animales de compañía'),
    'allergic' => _('no tiene animales de compañía y es alérgic@')}
  TP_PARTY = {'like-out' => _('le gusta mucho salir'), 'not-like-out' => _('no le gusta salir'), 'like-bars' => _('le gusta ir de bares'),
    'like-disco' => _('le gusta ir a la discoteca'), 'like-drink-friends' => _('le gusta ir a tomar algo con amigos'),
    'love-party' => _('le encanta la fiesta'), 'not-like-party' => _('no me gusta nada la fiesta')}
  TP_MUSIC = {'like-music' => _('le gusta la música'), 'no-like-music' => _('no le gusta la música')}
  TP_CINEMA = {'like-cinema' => _('Me gusta ir al cine'), 'not-like-cinema' => _('no me gusta ir al cine')}

  # Points for the Cellove index
  CELLOVE_USER_VISIT = 1
  CELLOVE_LIKE = 1
  CELLOVE_FIRST_MESSAGE = 3
  CELLOVE_FIRST_ACTIVITY_PROPOSAL = 3
  CELLOVE_3_STARS = 1
  CELLOVE_4_STARS = 2
  CELLOVE_5_STARS = 3
  CELLOVE_COMMON_STARS = 3
  CELLOVE_RECOMMENDED_USER = 5
  CELLOVE_CELESTINO_FAMILY = 5
  CELLOVE_CELESTINO_FRIEND = 6
  CELLOVE_CELESTINO_SPECIAL_FRIEND = 8
  CELLOVE_CELESTINO_EX_PARTNER = 10

  PICTURE_LIMIT = 12

  extend MinimumAgeValidatorHelper
  extend DatePresenter #allows us to use birth_date_(day|month|year) attrs for setting and getting date
  include UserRetrieval

  acts_as_messageable
  
  #relations
  has_many :pictures, as: :attachable
  has_many :characteristics, class_name: 'Characteristic', foreign_key: 'user_id'
  has_many :created_characterstics, class_name: 'Characteristic', foreign_key: 'creator_id'

  has_one :my_characteristics, class_name: 'Characteristic', conditions: Proc.new { "creator_id = #{self.id}" }
  has_many :recommendations, class_name: 'Recommendation', foreign_key: 'creator_id'
  has_many :recommenders, class_name: 'Recommendation', foreign_key: 'user_id'
  has_many :notes

  # user.likers will return people that have liked 'user'
  has_many :likers, class_name: 'Like', foreign_key: 'user_id'
  # user.likes will return people who 'user' has liked
  has_many :likes, class_name: 'Like', foreign_key: 'creator_id'

  has_many :user_visits
  has_many :visitors, through: :user_visits, source: :visitor

  # Useful for search later on
  scope :not_blocked, includes(:user_blocks).where(:user_blocks => { :user_id => nil })
  has_many :user_blocks
  has_many :blocked_users, through: :user_blocks, source: :blocked_user
  scope :not_hidden, includes(:user_hides).where(:user_hides => { :hidden_user_id => nil })
  has_many :user_hides
  has_many :hidden_users, through: :user_hides, source: :hidden_user
  #default_scope includes(:user_hides).where(:user_hides => { :user_id => nil })

  has_many :ratings_given, :class_name => "Rate", :foreign_key => :rater_id 
  has_many :rates, :class_name => "Rate", :foreign_key => :rateable_id, :dependent => :destroy
  has_many :raters, :through => :rates, :source => :rater  

  accepts_nested_attributes_for :my_characteristics

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
  attr_accessor :blocked
  attr_accessor :hidden
  present_date :birth_date

  # Setup accessible (or protected) attributes for your model
  attr_accessible :role_ids, :as => :admin
  attr_accessible :name, :email, :password, :password_confirmation,
    :remember_me, :surname, :screen_name, :gender, :orientation, :marital_status,
    :birth_date, :country, :postal_code, :town, :town_id,
    :newsletter_optin, :image_not_uploaded, :email_confirmation, :terms_and_conditions, 
    :physical_desc, :physical_style, :height, :weight, :complexion, :child,  :house, 
    :eyes, :hair, :hair_style, :religion_activity, :citizenship, :ethnicity, :language_level,
    :smoke, :diet, :alcohol, :drugs, :drug_frequency, :religion, :religion_opinion, 
    :study_level, :language, :job, :salary, :wedding_opinion, :animals, :music_genre, 
    :cinema_frequency, :cinema_genre, :like_sport, :like_read, :like_cinema, :like_walk, 
    :like_beach, :like_mountain, :like_quiet, :like_family, :like_friends,
    :description, :hobbies, :party, :music, :cinema, :lf_gender, :lf_orientation, 
    :lf_marital_status, :lf_age_between, :lf_age_to, :lf_city, :lf_country, :lf_postal_code,
    :lf_physical_desc, :lf_physical_style, :lf_height_between, :lf_weight_to, :lf_weight_between,
    :lf_complexion, :lf_child, :lf_smoke, :lf_diet, :lf_alcohol, :lf_drugs, :lf_religion, 
    :lf_study_level, :lf_language, :lf_job, :lf_salary,:lf_house, :lf_hair, :lf_hair_style, 
    :lf_eyes, :lf_party, :lf_ethnicity, :lf_citizenship, :lf_religion_activity, :lf_animals, 
    :lf_like_sport, :lf_like_read, :lf_like_cinema, :lf_like_walk, :lf_like_beach, :lf_like_mountain, 
    :lf_like_quiet, :lf_like_family, :lf_like_friends, :lf_language_level, :lf_height_to, :lf_relationship,
    :characteristics_attributes, :my_characteristics_attributes

  regular_user = lambda {|user| user.has_role?(:regular_user) }
  invited_user = lambda {|user| user.has_role?(:invited_user) }

  validates_presence_of :name
  validates_presence_of :surname, unless: invited_user
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

  def self.new_invitee(invitee)
    new do |u|
      u.email = invitee[:email]
      u.name = invitee[:name]
      u.generate_token(:invitation_code)
      u.add_role :invited_user
    end
  end
  
  def location
    [postal_code, town, country].compact.join(', ')
  end

  def age(dob = self.birth_date)
    if self.birth_date.nil?
      0
    else
      now = Time.now.utc.to_date
      now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
    end
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  scope :popular, where('users.created_at < ?', Time.now).with_role(:regular_user).limit(7)

  def full_name
    [name, surname].join(" ")
  end

  def mailboxer_email(object)
    email
  end

  def profile_picture
    self.pictures.where("main is true").limit(1).first || self.pictures.limit(1).first
  end

  def is_over_picture_limit?
    self.pictures.count >= PICTURE_LIMIT
  end

  def confirmed_recommenders
    self.recommenders.where("confirmed = true and denied = false")
  end

  def unconfirmed_recommenders
    self.recommenders.where("confirmed = false and denied = false")
  end

  def avg_characteristic(characteristic = 'romantic')
    recommendations = self.confirmed_recommenders
    if self.confirmed_recommenders.length > 0
      total = 0
      recommendations.each do |rec|
        c = rec.characteristic
        if c 
          total += c.send(characteristic.to_sym)
        end
      end
      # Absolute average (as in a number between 1 and 5)
      avg_absolute = total/self.confirmed_recommenders.length
      # Return the avg in percent
      ((avg_absolute-1.0)/4)*100
    else
      33
    end
  end

  def people_who_like_me
    self.likers.map { |l| l.creator }
  end

  def people_i_like
    self.likes.map { |l| l.user }
  end

  # Saves a new record in the UserVisit table,
  # where the current user visits the 'user' passed as a parameter.
  # If a tuple (user_id, visitor_id) already exists in UserVisit,
  # the visited_at attribute is updated
  def visited(user)
    visit = UserVisit.where("visitor_id = ? AND user_id = ?", self.id, user.id).first
    if visit
      visit.update_attributes({ visited_at: Time.now, seen: false })
    else
      visit = user.user_visits.build({ visited_at: Time.now })
      visit.visitor_id = self.id
      visit.save
    end
  end

  def number_of_visitors_since_last_login
    UserVisit.count(:conditions => "user_id = " + self.id.to_s + " AND seen = false")
  end

  def set_all_visits_seen
    visits = UserVisit.where("user_id = ? AND seen = false", self.id)
    visits.each do |visit|
      visit.seen = true
      visit.save
    end
  end

  def blocked_and_hidden_users
    users = []
    self.blocked_users.each do |user|
      user.blocked = true
      user.hidden = true if self.hidden_users.include?(user)
      users.push(user)
    end
    self.hidden_users.each do |user|
      user.hidden = true
      users.push(user) if !users.include?(user)
    end
    return users
  end

  # Rating
  def can_rate?(user_id)
    return true if (user_id != self.id)
    return false
  end

  def rate(stars, user)
    if can_rate? user.id
      rate = self.ratings_given.where("rateable_id = ?", user.id).first
      if rate
        rate.update_attributes(stars: stars)
      else
        self.rates.build do |r|
          r.stars = stars
          r.rateable_id = user.id
          r.rater_id = self.id
          r.save!
        end
      end

      if stars == 3
        user.add_to_cellove_index(User::CELLOVE_3_STARS)
      elsif stars == 4
        user.add_to_cellove_index(User::CELLOVE_4_STARS)
      elsif stars == 5
        user.add_to_cellove_index(User::CELLOVE_5_STARS)
      end

      if self.is_nice_couple?(user)
        user.add_to_cellove_index(User::CELLOVE_COMMON_STARS)
        self.add_to_cellove_index(User::CELLOVE_COMMON_STARS)
      end
    end
  end

  def rating(user_id)
    rate = self.ratings_given.where("rateable_id = ?", user_id).first
    if rate
      return rate.stars
    else
      0
    end
  end

  # Intersection of people who I rated and people who rated me
  def nice_couple
    users = []
    self.rates.each do |rate|
      # If we find a rater that's also present in the collection of ratings we've given
      if self.ratings_given.any?{ |r| r.rateable_id == rate.rater_id }
        user = User.find(rate.rater_id)
        # Include user if not already included
        users.push(user) if (!users.include?(user) && user != self)
      end
    end
    users
  end

  # Are current_user and user a nice couple?
  def is_nice_couple?(user)
    have_rated = self.ratings_given.any?{ |r| r.rateable_id == user.id }
    was_rated = self.rates.any?{ |r| r.rater_id == user.id }
    return true if have_rated && was_rated
    return false
  end

  # Cellove methods
  def add_to_cellove_index(points)
    self.cellove_index += points
    self.save
  end

  def cellove_percentage
    max = User.maximum("cellove_index")
    return ((self.cellove_index/max.to_f)*100.0).to_i if self.cellove_index != 0
    return 0
  end

  # Is this the first message we send to the recipient?
  def is_first_message_with?(recipient)
    number_of_receipts = recipient.mailbox.conversations.map { |c| c.receipts.where(receiver_id: self.id) }.flatten.length
    return true if number_of_receipts == 1 # Only 1 receipt, so first message was sent
    return false
  end

  # Is this the first activity proposal we send to the recipient?
  def is_first_activity_proposal_with?(recipient)
    number_of_activities = 0
    receipts = self.mailbox.conversations.map { |c| c.receipts.where(receiver_id: recipient.id) }.flatten
    from_recipient = recipient.mailbox.conversations.map { |c| c.receipts.where(receiver_id: self.id) }.flatten
    receipts.concat(from_recipient)

    receipts.each do |receipt|
      notification = Notification.find(receipt.notification_id)
      conversation = Conversation.find(notification.conversation_id)
      number_of_activities += 1 if !conversation.activity.nil?
    end

    return true if number_of_activities == 1 # 1 proposal, so this was the first
    return false
  end

  def my_notes(user)
    self.notes.where(evaluated_id: user.id)
  end


end

