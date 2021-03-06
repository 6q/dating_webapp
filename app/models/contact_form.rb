class ContactForm < MailForm::Base
  attribute :name,      :validate => true
  attribute :surname,   :validate => true
  attribute :email,     :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i

  attribute :message
  attribute :nickname,  :captcha  => true

  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  def headers
    {
      :subject => "[Cellove] Contact form",
      :to => ENV['CONTACT_EMAIL'] || "help@cellove.com",
      :from => %("#{name}" <#{email}>)
    }
  end
end
