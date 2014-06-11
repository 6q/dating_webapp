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
#  seeking                :string(255)
#  marital_status         :string(255)
#  birth_date             :date
#  postal_code            :string(255)
#  city                   :string(255)
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
#  lf_age_from            :string(255)
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
#  house                  :text
#  eyes                   :text
#  hair                   :text
#  hair_style             :text
#  citizenship            :text
#  ethnicity              :text
#  language_level         :text
#  wedding_opinion        :text
#  music_genre            :text
#  cinema_frequency       :text
#  cinema_genre           :text
#  like_sport             :boolean
#  like_read              :boolean
#  like_cinema            :boolean
#  like_quiet             :boolean
#  like_walk              :boolean
#  like_mountain          :boolean
#  like_beach             :boolean
#  like_family            :boolean
#  like_friends           :boolean
#  religion_activity      :text
#  invitation_code        :string(255)
#  lf_house               :text
#  lf_hair                :text
#  lf_hair_style          :text
#  lf_eyes                :text
#  lf_like_sport          :boolean
#  lf_like_read           :boolean
#  lf_like_cinema         :boolean
#  lf_like_quiet          :boolean
#  lf_like_walk           :boolean
#  lf_like_mountain       :boolean
#  lf_like_beach          :boolean
#  lf_like_family         :boolean
#  lf_like_friends        :boolean
#  lf_religion_activity   :text
#  lf_citizenship         :text
#  lf_ethnicity           :text
#  lf_animals             :text
#  lf_party               :text
#  lf_language_level      :text
#  cellove_index          :integer          default(0)
#  lf_relationship        :string(255)
#  background             :integer          default(1)
#  progress_status        :integer          default(1)
#  fake                   :boolean
#  banned                 :boolean
#  provider               :string(255)
#  uid                    :string(255)
#  oauth_token            :string(255)
#  oauth_expires_at       :datetime

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
  scope :popular, select("users.*, count(user_visits.id) AS visits_count, count(likes.id) AS likes_count").
    joins('LEFT JOIN user_visits ON user_visits.user_id = users.id').
    joins('LEFT JOIN likes ON likes.creator_id = users.id').
    group("users.id").
    order("visits_count DESC, likes_count DESC")
  scope :women, where(gender: 'female')
  scope :men, where(gender: 'male')
  scope :with_picture, joins(:pictures).order('pictures.main IS NULL')

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

  # user.likers will return Like objects of people that have liked 'user'
  has_many :likers, class_name: 'Like', foreign_key: 'user_id'
  # user.likes will return Likes objects of people who 'user' has liked
  has_many :likes, class_name: 'Like', foreign_key: 'creator_id'
  has_many :user_likes, through: :likes, source: :user
  has_many :user_likers, through: :likers, source: :creator

  has_many :user_visits
  has_many :visitors, through: :user_visits, source: :visitor

  has_many :user_blocks
  has_many :blocked_users, through: :user_blocks, source: :blocked_user

  has_many :user_hides
  has_many :hidden_users, through: :user_hides, source: :hidden_user

  has_many :user_mailings
  has_many :mailed_users, through: :user_mailings, source: :mailed_user

  # rates that the user has done
  has_many :ratings_given, :class_name => "Rate", :foreign_key => :rater_id
  # ratings that have been received by the user
  has_many :rates, :class_name => "Rate", :foreign_key => :rateable_id, :dependent => :destroy
  # List of people that has given a rating to this user
  has_many :raters, :through => :rates, :source => :rater

  has_many :notifications, :class_name => "CelloveNotification", :foreign_key => :receiver_id
  has_many :invitations, :class_name => "Invitation", :foreign_key => :invitor_id
  has_many :searches

  accepts_nested_attributes_for :my_characteristics

  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  #virtual attributes
  attr_accessor :terms_and_conditions
  attr_accessor :image_not_uploaded
  attr_accessor :blocked
  attr_accessor :hidden
  present_date :birth_date

  # Setup accessible (or protected) attributes for your model
  attr_accessible :role_ids, :email, :name, :surname, :screen_name, :banned, :fake, :encrypted_password, :reset_password_token, :reset_password_sent_at, :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip, :gender, :orientation, :marital_status, :birth_date, :postal_code, :city, :country, :newsletter_optin, :latitude, :longitude, :physical_style, :physical_desc, :height, :weight, :complexion, :child, :smoke, :diet, :alcohol, :religion, :animals, :study_level, :language, :job, :salary, :description, :party, :music, :cinema, :lf_gender, :lf_orientation, :lf_marital_status, :lf_age_from, :lf_age_to, :lf_city, :lf_country, :lf_postal_code, :lf_physical_style, :lf_physical_desc, :lf_height_between, :lf_height_to, :lf_weight_between, :lf_weight_to, :lf_complexion, :lf_child, :lf_smoke, :lf_diet, :lf_alcohol, :lf_religion, :lf_study_level, :lf_language, :lf_job, :lf_salary, :house, :eyes, :hair, :hair_style, :citizenship, :ethnicity, :language_level, :wedding_opinion, :music_genre, :cinema_frequency, :cinema_genre, :like_sport, :like_read, :like_cinema, :like_quiet, :like_walk, :like_mountain, :like_beach, :like_family, :like_friends, :religion_activity, :invitation_code, :lf_house, :lf_hair, :lf_hair_style, :lf_eyes, :lf_like_sport, :lf_like_read, :lf_like_cinema, :lf_like_quiet, :lf_like_walk, :lf_like_mountain, :lf_like_beach, :lf_like_family, :lf_like_friends, :lf_religion_activity, :lf_citizenship, :lf_ethnicity, :lf_animals, :lf_party, :lf_language_level, :cellove_index, :lf_relationship, :background, :progress_status, :unconfirmed_email, :confirmation_token, :confirmed_at, :confirmation_sent_at, :seeking, :as => :admin
  attr_accessible :name, :email, :password,
    :remember_me, :surname, :screen_name, :gender, :orientation, :seeking, :marital_status,
    :birth_date, :country, :postal_code, :city,
    :newsletter_optin, :image_not_uploaded, :terms_and_conditions,
    :physical_desc, :physical_style, :height, :weight, :complexion, :child,  :house,
    :eyes, :hair, :hair_style, :religion_activity, :citizenship, :ethnicity, :language_level,
    :smoke, :diet, :alcohol, :drugs, :drug_frequency, :religion, :religion_opinion,
    :study_level, :language, :job, :salary, :wedding_opinion, :animals, :music_genre,
    :cinema_frequency, :cinema_genre, :like_sport, :like_read, :like_cinema, :like_walk,
    :like_beach, :like_mountain, :like_quiet, :like_family, :like_friends,
    :description, :hobbies, :party, :music, :cinema, :lf_gender, :lf_orientation,
    :lf_marital_status, :lf_age_from, :lf_age_to, :lf_city, :lf_country, :lf_postal_code,
    :lf_physical_desc, :lf_physical_style, :lf_height_between, :lf_weight_to, :lf_weight_between,
    :lf_complexion, :lf_child, :lf_smoke, :lf_diet, :lf_alcohol, :lf_drugs, :lf_religion,
    :lf_study_level, :lf_language, :lf_job, :lf_salary,:lf_house, :lf_hair, :lf_hair_style,
    :lf_eyes, :lf_party, :lf_ethnicity, :lf_citizenship, :lf_religion_activity, :lf_animals,
    :lf_like_sport, :lf_like_read, :lf_like_cinema, :lf_like_walk, :lf_like_beach, :lf_like_mountain,
    :lf_like_quiet, :lf_like_family, :lf_like_friends, :lf_language_level, :lf_height_to, :lf_relationship,
    :characteristics_attributes, :my_characteristics_attributes, :fake, :banned,
    :provider, :uid, :oauth_token, :oauth_expires_at

  attr_accessor :is_rec # if user is created by reccomendation

  regular_user = lambda {|user| user.has_role?(:regular_user) }
  premium_user = lambda {|user| user.has_role?(:premium_user) }
  invited_user = lambda {|user| user.has_role?(:invited_user) }

  validates_presence_of :name
  validates_presence_of :surname, if: regular_user
  validates_presence_of :city, if: regular_user
  validates_presence_of :country, if: regular_user
  validates :email, presence: true
  validates :password, presence: true, on: :create

  #Validations only performed on regular users, not matchmakers
  validates_presence_of :gender, if: regular_user
  validates_presence_of :city, if: regular_user
  validates_presence_of :birth_date_month, :birth_date_day, :birth_date_year, if: regular_user

  validates :birth_date, presence: true, minimum_age: true, if: regular_user

  geocoded_by :location
  after_validation :geocode

  def has_all_fields?
    (self.has_role?(:regular_user) || self.has_role?(:premium_user)) && self.city && self.country && self.name
  end

  def self.new_invitee(invitee, is_rec=false)
    new do |u|
      u.email = invitee[:email]
      u.name = invitee[:name]
      u.generate_token(:invitation_code)
      u.password = SecureRandom.urlsafe_base64[(0..5)]
      u.is_rec = is_rec
      u.add_role :invited_user
      u.add_role :regular_user
    end
  end

  # def hidden_users(hidden_user_ids)
  #   where("users.id NOT IN (?)", hidden_user_ids)
  # end

  # Get all user ids of the people for which I appear in their blocked list
  def invisible_to_me
    UserBlock.where(blocked_user_id: self.id).pluck(:user_id)
  end

  # Includes all users that you have hidden or that have blocked you
  def get_all_invisible_to_me
    #invited_users = User.with_role(:invited_user).pluck('users.id')
    deleted_users = User.where('deleted_at is not null').pluck('users.id')
    users = self.hidden_user_ids.concat(self.invisible_to_me).concat(deleted_users).concat([self.id])
    if users == []
      # Needed to fix MySQL bug where an '.. NOT IN (NULL)' query does not work
      return [self.id]
    else
      return users
    end
  end

  def matching_gender
    self.lf_gender || (gender == 'male' ? 'female' : 'male')
  end

  def matching_postal_code
    self.lf_postal_code || self.postal_code
  end

  def location
    [city, country].compact.join(', ')
  end

  ransacker :years_start, :formatter => proc { |age| age.to_i.years.ago } do |parent|
    parent.table[:birth_date]
  end
  ransacker :years_end, :formatter => proc { |age| age.to_i.years.ago - 1.year } do |parent|
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
    self.recommenders.where(confirmed: true, denied: false).where(deleted_at: nil)
  end

  def unconfirmed_recommenders
    self.recommenders.where(confirmed: false, denied: false).where(deleted_at: nil)
  end

  def confirmed_recommendations
    self.recommendations.where(confirmed: true, denied: false).where(deleted_at: nil)
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
      50
    end
  end

  def my_charact_percent(charact = 'romantic')
    # get my_characteristic value
    c = self.my_characteristics.send(charact)
    percent = (c-1)*25
  end

  # Intersection of people who I rated and people who rated me
  def self.nice_couple(user, order)
    order ||= 'rates_updated_at desc'

    if order == 'distance asc'
      by_distance = true
      order = nil
    end

    common_query = User
      .select('users.*, rates.updated_at as rates_updated_at')
      .where("users.id NOT IN (?)", user.get_all_invisible_to_me)
      .where("users.gender = ?", user.matching_gender)
      .where("users.lf_gender = ?", user.gender)

    user_rates = common_query.joins('INNER JOIN rates ON rates.rateable_id = users.id').where('rater_id = ?', user.id).order(order)
    user_ratings = common_query.joins('INNER JOIN rates ON rates.rater_id = users.id').where('rateable_id = ?', user.id)

    nice = User.find_by_sql(user_ratings.union(user_rates).to_sql.gsub(/^\( | \)$/, '')).uniq
    nice = user.nearbys(100000).where(id: nice.map(&:id)) if by_distance

    nice
  end

  def self.people_who_like_me(user, order)
    order ||= 'likes.updated_at desc'

    if order == 'distance asc'
      by_distance = true
      order = nil
    end

    likes = user.user_likers
      .order(order)
      .where("likes.id not in (#{user.get_all_invisible_to_me.join(',')})")
      .where(gender: user.matching_gender)

    likes = user.nearbys(100000).where(id: likes.pluck(:id)) if by_distance

    likes
  end

  def self.people_i_like(user, order)
    order ||= 'created_at desc'

    if order == 'distance asc'
      by_distance = true
      order = nil
    end

    likes = user.user_likes
      .order(order)
      .where("likes.id not in (#{user.get_all_invisible_to_me.join(',')})")
      .where(gender: user.matching_gender)

    likes = user.nearbys(100000).where(id: likes.pluck(:id)) if by_distance

    likes
  end

  def self.all_visitors(user, order = 'visited_at desc')
    order ||= 'visited_at desc'

    if order == 'distance asc'
      by_distance = true
      order = nil
    end

    hits = user.visitors
      .order(order)
      .where("users.id not in (#{user.get_all_invisible_to_me.join(',')})")
      .where(gender: user.matching_gender)

    hits = user.nearbys(100000).where(id: hits.pluck(:id)) if by_distance

    hits
  end

  # Me gusta
  # Where current_user likes the user passed as a parameter
  def like(user)
    like = self.likes.build({})
    like.user_id = user.id
    if like.save
      send_notification_email(:like, user)
      return true
    else
      return false
    end
  end

  def likes?(user)
    like = self.likes.where(user_id: user.id).last
    return !like.nil?
  end

  def unlike(user)
    like = self.likes.where(user_id: user.id).last
    if like
      like.destroy
    end
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
        rate.update_attributes(stars: stars, seen: false)
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
    else
      visit = user.user_visits.build({ visited_at: Time.now })
      visit.visitor_id = self.id
      visit.save
    end

    if visit && !self.general_settings.anonymous_browsing
      user.notifications.create({ sender_id: self.id, notifiable_id: visit.id, notifiable_type: 'visit' })
      send_notification_email(:profile_visit, user)
    end
  end

  def set_all_visits_seen
    visits = UserVisit.where("user_id = ? AND seen = false", self.id)
    visits.each do |visit|
      visit.seen = true
      visit.save
    end
  end

  def set_all_likes_seen
    likers.update_all(seen: true)
  end

  def set_all_rates_seen
    raters.update_all(seen: true)
  end

  def online?
    updated_at > 30.seconds.ago
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

  def blocked?(user)
    !user_blocks.where("blocked_user_id = ?", user.id).first.nil?
  end

  def hidden?(user)
    !user_hides.where("hidden_user_id = ?", user.id).first.nil?
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
    User.record_timestamps=false
    self.cellove_index += points
    self.save
    User.record_timestamps=true
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

  def upgrade_to_premium
    if self.has_role?(:regular_user)
      self.remove_role :regular_user
      self.add_role :premium_user
      self.save
    end
  end

  # TODO: Refactor to other class
  def send_notification_email(notification_type, recipient)
    settings = recipient.general_settings
    send_mail = Proc.new { UserMailer.send(notification_type, self, recipient).deliver }

    if settings && recipient.online? && !settings.no_email_online && settings.send(notification_type.to_sym)
      send_mail.call
    elsif settings && settings.send(notification_type.to_sym)
      send_mail.call
    elsif settings.nil?
      send_mail.call
    end
  end

  def update_profile_progress
    progress = ProfileCompleteness.new(self).get_profile_completeness
    self.progress_status = progress.to_i
  end
  private :update_profile_progress
  before_update :update_profile_progress, :if => Proc.new {|u| u.progress_status < 100}

  def set_gender
    gender_match = {
      "man" => :male,
      "woman" => :female
    }

    self.gender = gender_match[seeking.split.first] if seeking.present?
    self.lf_gender = gender_match[seeking.split.last] if seeking.present?
  end
  before_validation :set_gender

  def visitor?(user)
    user_visits.where('visitor_id = :id', id: user.id).first
  end

  def liker?(user)
    likers.where('creator_id = :id', id: user.id).first
  end

  def active_for_authentication?
    super && !self.banned?
  end

  def soft_delete
    # assuming you have deleted_at column added already
    update_attribute(:deleted_at, Time.current)
  end

  def display_name
    self.screen_name.present? ? self.screen_name : self.name
  end

  def can_interact_with?(user)
    if user.general_settings.age_restriction && user.lf_age_from.present? && user.lf_age_to.present?
      self.age >= user.lf_age_from.to_i && self.age <= user.lf_age_to.to_i || user.likes?(self)
    else
      true
    end
  end

  def can_message_to?(user)
    if user.general_settings.receive_messages_only_from_likes
      if self.liker?(user)
        true
      else
        false
      end
    else
      true
    end
  end

  def can_chat_to?(user)
    if user.general_settings.allow_chat_only_from_likes
      if self.liker?(user)
        true
      else
        false
      end
    else
      true
    end
  end

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first
  end

  def self.custom_newsletters
    User.joins(:general_settings).where(confirmation_token: nil, general_settings: { user_suggestions: true }).find_each(:batch_size => 200) do |user|
      new_inedit_users_near_me = user.new_inedit_users_near_me(12, 50)
      if new_inedit_users_near_me && new_inedit_users_near_me.count >= 4
        user.add_mailing_sent_users new_inedit_users_near_me
        UserMailer.custom_newsletter(user, new_inedit_users_near_me).deliver
      end
    end
    true
  rescue
    false
  end

  def add_mailing_sent_users(users)
    users.each do |user|
      self.user_mailings.create({ sent_user_id: user.id })
    end
  end
end
