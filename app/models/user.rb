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
#  height                 :integer
#  weight                 :integer
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
#  lf_child_want          :string(255)
#  lf_smoke               :string(255)
#  lf_smoke_tolerance     :string(255)
#  lf_diet                :string(255)
#  lf_alcohol             :string(255)
#  lf_drugs               :string(255)
#  lf_drug_frequency      :string(255)
#  lf_religion            :string(255)
#  lf_religion_opinion    :string(255)
#  lf_animal_like         :string(255)
#  lf_animal_have         :string(255)
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
#



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
  SMOKE = {'smoker' => 'Fumo', 'non-smoker' => 'No fumo', 'smoker-hater' => 'Soy antitabaco','not-mind-smoke' => _('No me molesta el humo'),
    'smoke-leave-couple' => _('Fumo pero lo dejaría por mi pareja'), 'social-smoker' => _('Soy fumador social')}
  RELIGION = {'agnostic' => _('agnóstico'), 'atheist' => _('ateo'), 'christian' => _('cristiano'), 'jewish' => _('judío'), 
    'catholic' => _('católico'), 'muslim' => _('musulmán'), 'hindu' => _('indú'), 'buddhist' => _('budista')}
  ETHNICITY = {'hispanic' => _('hispana'), 'arab' => _('árabe'), 'indian' => _('india'), 'european' => _('europea'), 
    'african' => _('africana'), 'asian' => _('asiática') }
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
  CINEMA = {'like-cinema' => _('Me gusta ir al cine'), 'not-like-cinema' => _('no me gusta ir al cine')}
  CINEMA_FREQUENCY = {'occasionally' => _('solo ocasionalemnete'), 'often' => _('muy a menudo')}
  CINEMA_GENRE = {'romantic' => _('románticas'), 'dramas' => _('dramas'), 'comedies' => _('comedias'), 'police' => _('policíacas'),
    'terror' => _('terror')}

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
    :lf_like_quiet, :lf_like_family, :lf_like_friends, :lf_language_level,
    :characteristics_attributes

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

  ransacker :years, :formatter => proc { |age| age.to_i.years.ago } do |parent|
    parent.table[:birth_date]
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
      (avg_absolute/5.0)*100
    else
      33
    end
  end

end

