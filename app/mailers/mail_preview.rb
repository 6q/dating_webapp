class MailPreview < MailView
  def welcome_email
    user = User.new do |u|
      u.name = 'Jill Smith'
      u.email = 'name@example.com'
    end
    mail = UserMailer.welcome_email(user)
  end

  def invite_user
    user = User.new do |u|
      u.name = 'Jill Smith'
      u.email = 'name@example.com'
    end
    email = 'info@quantic.es'
    mail = UserMailer.invite_user(user, email, 'invitation_code_1')
  end

  def invite_celestino
    user = User.new do |u|
      u.name = 'Jill Smith'
      u.email = 'name@example.com'
    end
    email = 'info@quantic.es'
    mail = UserMailer.invite_celestino(user, email, 'invitation_code_2')
  end

  def like
    user = User.new do |u|
      u.name = 'Jill Smith'
      u.email = 'name@example.com'
    end
    email = 'info@quantic.es'
    mail = UserMailer.like(user, user)
  end

  def profile_visit
    user = User.new do |u|
      u.name = 'Jill Smith'
      u.email = 'name@example.com'
    end
    email = 'info@quantic.es'
    mail = UserMailer.profile_visit(user, user)
  end

  def receive_message
    user = User.new do |u|
      u.name = 'Jill Smith'
      u.email = 'name@example.com'
    end
    email = 'info@quantic.es'
    mail = UserMailer.receive_message(user, user)
  end

  def star_rating
    user = User.new do |u|
      u.name = 'Jill Smith'
      u.email = 'name@example.com'
    end
    email = 'info@quantic.es'
    mail = UserMailer.star_rating(user, user)
  end

  def celestino_recommendation
    user = User.new do |u|
      u.name = 'Jill Smith'
      u.email = 'name@example.com'
    end
    email = 'info@quantic.es'
    mail = UserMailer.celestino_recommendation(user, user)
  end

  def custom_newsletter
    user = User.new do |u|
      u.name = 'Jill Smith'
      u.email = 'name@example.com'
    end
    users_list = User.order("RAND()").first(12)
    mail = UserMailer.custom_newsletter(user, users_list)
  end
end
