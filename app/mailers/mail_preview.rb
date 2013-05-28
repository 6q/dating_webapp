class MailPreview < MailView
  def welcome_email
    user = Struct.new(:email, :name).new('name@example.com', 'Jill Smith')
    mail = UserMailer.welcome_email(user)
  end

  def invite_user
    user = Struct.new(:email, :name).new('name@example.com', 'Jill Smith')
    email = 'test@season.es'
    mail = UserMailer.invite_user(user, email, 'invitation_code_1')
  end

  def invite_celestino
    user = Struct.new(:email, :name).new('name@example.com', 'Jill Smith')
    email = 'test@season.es'
    mail = UserMailer.invite_celestino(user, email, 'invitation_code_2')
  end
end
