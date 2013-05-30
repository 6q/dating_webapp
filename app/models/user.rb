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
#  height                 :decimal(, )
#  weight                 :decimal(, )
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
#  lf_height_between      :decimal(, )
#  lf_height_to           :decimal(, )
#  lf_weight_between      :decimal(, )
#  lf_weight_to           :decimal(, )
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
#  lf_relationship        :string(255)
#

require_dependency 'minimum_age_validator'

class User < ActiveRecord::Base
  extend MinimumAgeValidatorHelper
  extend DatePresenter #allows us to use birth_date_(day|month|year) attrs for setting and getting date
  include UserConstants
  include UserRetrieval

  acts_as_messageable
  
  #scopes
  scope :not_hidden, includes(:user_hides).where(:user_hides => { :hidden_user_id => nil, :user_id => nil })
  scope :not_blocked, includes(:user_blocks).where(:user_blocks => { :user_id => nil })
  scope :sort_interactions, select("users.*, count(notifications.id) AS notifications_count")
                      .joins(:messages)
                      .group("users.id, notifications.id")
                      .order("notifications_count DESC")

  #relations
  has_many :pictures, as: :attachable
  has_many :characteristics, class_name: 'Characteristic', foreign_key: 'user_id'
  has_many :created_characterstics, class_name: 'Characteristic', foreign_key: 'creator_id'

  has_one :general_settings, class_name: 'GeneralSetting', foreign_key: 'user_id'
  accepts_nested_attributes_for :general_settings
  
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

  has_many :user_blocks
  has_many :blocked_users, through: :user_blocks, source: :blocked_user

  has_many :user_hides
  has_many :hidden_users, through: :user_hides, source: :hidden_user

  has_many :ratings_given, :class_name => "Rate", :foreign_key => :rater_id 
  has_many :rates, :class_name => "Rate", :foreign_key => :rateable_id, :dependent => :destroy
  has_many :raters, :through => :rates, :source => :rater

  has_many :notifications, :class_name => "CelloveNotification", :foreign_key => :receiver_id
  has_many :invitations, :class_name => "Invitation", :foreign_key => :invitor_id
  has_many :searches

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

  # Get all user ids of the people for which I appear in their blocked list
  def invisible_to_me
    UserBlock.where(blocked_user_id: self.id).map{ |u| u.user_id }
  end
  
  def location
    [postal_code, town, country].compact.join(', ')
  end

  ransacker :years, :formatter => proc { |age| age.to_i.years.ago.end_of_year } do |parent|
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
    self.recommenders.where(confirmed: true, denied: false)
  end

  def unconfirmed_recommenders
    self.recommenders.where(confirmed: false, denied: false)
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

  # Intersection of people who I rated and people who rated me
  def self.nice_couple(user)
    User.joins(:rates).joins(:ratings_given).where("users.id != ?", user.id)
  end

  def self.people_who_like_me(user)
    #self.likers.map { |l| l.creator }
    # Need an AR::Relation for the Search part of Ransack :\
    user.likers.where(nil)
  end

  def self.people_i_like(user)
    #self.likes.map { |l| l.user }
    # Need an AR::Relation for the Search part of Ransack :\
    user.likes.where(nil)
  end

  def self.all_visitors(user)
    user.visitors.where(nil)
  end

  # Me gusta
  # Where current_user likes the user passed as a parameter
  def like(user)
    like = self.likes.build({})
    like.user_id = user.id
    if like.save
      return true
    else
      return false
    end
    send_notification_email(:like, user)
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
        rate = self.rates.build do |r|
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
      if stars == 4 || stars == 5
        user.notifications.create({ sender_id: self.id, notifiable_id: rate.id, notifiable_type: 'couple' })
        send_notification_email(:star_rating, user)
      end

      if self.is_nice_couple?(user)
        user.add_to_cellove_index(User::CELLOVE_IS_NICE_COUPLE)
        self.add_to_cellove_index(User::CELLOVE_IS_NICE_COUPLE)
      end
    else
      false
    end
  end

  # Saves a new record in the UserVisit table,
  # where the current user visits the 'user' passed as a parameter.
  # If a tuple (user_id, visitor_id) already exists in UserVisit,
  # the visited_at attribute is updated
  def visited(user)
    visit = UserVisit.where("visitor_id = ? AND user_id = ?", self.id, user.id).first
    if visit
      visit.update_attributes({ visited_at: Time.now, seen: false })
      user.notifications.create({ sender_id: self.id, notifiable_id: visit.id, notifiable_type: 'visit' })
    else
      visit = user.user_visits.build({ visited_at: Time.now })
      visit.visitor_id = self.id
      if visit.save
        user.notifications.create({ sender_id: self.id, notifiable_id: visit.id, notifiable_type: 'visit' })
      end
    end
    send_notification_email(:profile_visit, user)
  end

  def set_all_visits_seen
    visits = UserVisit.where("user_id = ? AND seen = false", self.id)
    visits.each do |visit|
      visit.seen = true
      visit.save
    end
  end

  def online?
    updated_at > 5.minutes.ago
  end

  ransacker :smoker, :formatter => proc { |v| v.split } do |parent|
    parent.table[:smoke]
  end

  def self.is_smoker
    %w{smoker smoke-leave-couple social-smoker}
  end

  ransacker :children, :formatter => proc { |v| v.split } do |parent|
    parent.table[:child]
  end

  def self.have_children
    %w{children have-children-want-more have-children-no-want-more}
  end

  def number_of_visitors_since_last_login
    UserVisit.count(:conditions => "user_id = " + self.id.to_s + " AND seen = false")
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

  def rating(user_id)
    rate = self.ratings_given.where("rateable_id = ?", user_id).first
    if rate
      return rate.stars
    else
      0
    end
  end

  # Are current_user and user a nice couple?
  def is_nice_couple?(user)
    have_rated = self.ratings_given.any?{ |r| r.rateable_id == user.id }
    was_rated = self.rates.any?{ |r| r.rater_id == user.id }
    return have_rated && was_rated
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

  def has_messages_with?(recipient)
    number_of_receipts = recipient.mailbox.conversations.map { |c| c.receipts.where(receiver_id: self.id) }.flatten.length
    return number_of_receipts > 0
  end

  # Is this the first message we send to the recipient?
  def is_first_message_with?(recipient)
    number_of_receipts = recipient.mailbox.conversations.map { |c| c.receipts.where(receiver_id: self.id) }.flatten.length
    return number_of_receipts == 1 # Only 1 receipt, so first message was sent
  end

  # Is this the first activity proposal we send to the recipient?
  def is_first_activity_proposal_with?(recipient)
    number_of_activities = 0
    receipts = self.mailbox.conversations.map { |c| c.receipts.where(receiver_id: recipient.id, mailbox_type: "inbox") }.flatten
    from_recipient = recipient.mailbox.conversations.map { |c| c.receipts.where(receiver_id: self.id, mailbox_type: "inbox") }.flatten
    receipts.concat(from_recipient)

    receipts.each do |receipt|
      notification = Notification.find(receipt.notification_id)
      conversation = Conversation.find(notification.conversation_id)
      number_of_activities += 1 if !conversation.activity.nil?
    end

    return number_of_activities == 1 # true if 1 proposal (this method is called AFTER creating the first prop)
  end

  def my_notes(user)
    self.notes.where(evaluated_id: user.id)
  end

  # TODO: Refactor to other class
  def send_notification_email(notification_type, recipient)
    settings = recipient.general_settings
    send_mail = Proc.new { UserMailer.send(notification_type, self, recipient).deliver }

    if recipient.online? && !settings.no_email_online && settings.send(notification_type.to_sym)
      if pass_checks(settings, recipient)
        send_mail.call
      end
    elsif settings.send(notification_type.to_sym)
      if pass_checks(settings, recipient)
        send_mail.call
      end
    end
  end

  private
    def pass_checks(settings, recipient)
      to_check = []
      to_check.push(:show_only_nearby) if settings.show_only_nearby
      to_check.push(:show_only_matching_profiles) if settings.show_only_matching_profiles
      to_check.push(:show_only_people_who_like_me) if settings.show_only_people_who_like_me
      to_check.push(:show_only_buena_pareja) if settings.show_only_buena_pareja
      to_check.push(:show_only_pm) if settings.show_only_pm
      to_check.push(:show_only_rated_me) if settings.show_only_rated_me
      passed_checks = true

      to_check.each do |check|
        case check
        when :show_only_nearby
          passed_checks = false if !nearbys(User::DEFAULT_NEARBY_DISTANCE).include?(recipient)
        when :show_only_matching_profiles
          # Not sure what this does :\
        when :show_only_people_who_like_me
          passed_checks = false if !self.likes.include?(recipient)
        when :show_only_buena_pareja
          passed_checks = false if !self.is_nice_couple?(recipient)
        when :show_only_pm
          passed_checks = false if !self.has_messages_with?(recipient)
        when :show_only_rated_me
          passed_checks = false if !recipient.raters.include?(self)
        end
      end
      return passed_checks
    end

end
