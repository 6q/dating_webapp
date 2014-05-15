class MailPreview < MailView
  def welcome_email
    user = Struct.new(:email, :name).new('name@example.com', 'Jill Smith')
    mail = UserMailer.welcome_email(user)
  end

  def invite_user
    user = Struct.new(:email, :name).new('name@example.com', 'Jill Smith')
    email = 'info@quantic.es'
    mail = UserMailer.invite_user(user, email, 'invitation_code_1')
  end

  def invite_celestino
    user = Struct.new(:email, :name).new('name@example.com', 'Jill Smith')
    email = 'info@quantic.es'
    mail = UserMailer.invite_celestino(user, email, 'invitation_code_2')
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
