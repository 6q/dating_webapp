#encoding: utf-8
class UserMailer < ActionMailer::Base
  helper :user
  default from: "Cellove.com <mail@cellove.com>"

  def prevent_delivery_to_unconfirmed
    if (@user && !@user.confirmed?) || (@recipient && !@recipient.confirmed?)
      mail.perform_deliveries = false
    end
  end
  private :prevent_delivery_to_unconfirmed

  def welcome_email(user)
    @user = user
    mail(:to => user.email, :subject => _('Bienvenido a Cellove | Cellove.com'))
    prevent_delivery_to_unconfirmed
  end

  def invite_user(user, email_address, invitation_code)
    @user = user
    @url = new_user_registration_url + '?invitation_code=' + invitation_code
    mail(:to => email_address, :subject => _('%{name} te invita a usar Cellove') % {name: user.name})
    prevent_delivery_to_unconfirmed
  end

  def invite_celestino(user, email_address, invitation_code)
    @user = user
    @url = new_user_registration_url + '?invitation_code=' + invitation_code
    mail(:to => email_address, :subject => _('%{name} te invita a usar Cellove') % {name: user.name})
    prevent_delivery_to_unconfirmed
  end

  # Email notifications
  def receive_message(sender, recipient)
    @sender = sender
    @recipient = recipient
    mail(:to => @recipient.email, :subject => _('Nuevo mensaje recibido | Cellove.com'))
    prevent_delivery_to_unconfirmed
  end

  def profile_visit(visitor, visited)
    @sender = visitor
    @recipient = visited
    mail(:to => @recipient.email, :subject => _('Alguien ha visitado tu perfil | Cellove.com'))
    prevent_delivery_to_unconfirmed
  end

  def like(sender, recipient)
    @sender = sender
    @recipient = recipient
    mail(:to => @recipient.email, :subject => _('¡Le gustas a alguien! | Cellove.com'))
    prevent_delivery_to_unconfirmed
  end

  def star_rating(sender, recipient)
    @sender = sender
    @recipient = recipient
    mail(:to => @recipient.email, :subject => _('Alguien cree que hace buena pareja contigo | Cellove.com'))
    prevent_delivery_to_unconfirmed
  end

  def celestino_recommendation(sender, recipient)
    @sender = sender
    @recipient = recipient
    mail(:to => @recipient.email, :subject => _('Has recibido una recomendación | Cellove.com'))
    prevent_delivery_to_unconfirmed
  end

  def report(reporter, reported)
    @reporter = reporter
    @reported = reported
    mail(to: 'cellove@cellove.com', subject: _('Perfil denunciado | Cellove.com'))
  end

  def custom_newsletter(user, users_list)
    @user       = user
    @users_list = users_list
    mail(:to => user.email, :subject => _('Sugerencias | Cellove.com'))
    prevent_delivery_to_unconfirmed
  end

end
