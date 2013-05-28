class MailPreview < MailView
  def welcome_email
    user = Struct.new(:email, :name).new('name@example.com', 'Jill Smith')
    mail = UserMailer.welcome_email(user)
  end
end
