#encoding: utf-8
class UserMailer < ActionMailer::Base
  default from: "Cellove.com <mail@cellove.com>"

  def prevent_delivery_to_unconfirmed
    if (@user && !@user.confirmed?) || (@recipient && !@recipient.confirmed?)
      mail.perform_deliveries = false
    end
  end
  private :prevent_delivery_to_unconfirmed

  def welcome_email(user)
    @user = user
    mail(:to => user.email, :subject => _('Bienvenido a Cellove')._(' | Cellove.com'))
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
    mail(:to => @recipient.email, :subject => _('Nuevo mensaje recibido')._(' | Cellove.com'))
    prevent_delivery_to_unconfirmed
  end

  def profile_visit(visitor, visited)
    @sender = visitor
    @recipient = visited
    mail(:to => @recipient.email, :subject => _('Alguien ha visitado tu perfil')._(' | Cellove.com'))
    prevent_delivery_to_unconfirmed
  end

  def like(sender, recipient)
    @sender = sender
    @recipient = recipient
    mail(:to => @recipient.email, :subject => _('¡Le gustas a alguien!')._(' | Cellove.com'))
    prevent_delivery_to_unconfirmed
  end

  def star_rating(sender, recipient)
    @sender = sender
    @recipient = recipient
    mail(:to => @recipient.email, :subject => _('Alguien cree que hace buena pareja contigo')._(' | Cellove.com'))
    prevent_delivery_to_unconfirmed
  end

  def celestino_recommendation(sender, recipient)
    @sender = sender
    @recipient = recipient
    mail(:to => @recipient.email, :subject => _('Has recibido una recomendación')._(' | Cellove.com'))
    prevent_delivery_to_unconfirmed
  end

  def report(reporter, reported)
    @reporter = reporter
    @reported = reported
    mail(to: 'cellove@cellove.com', subject: _('Perfil denunciado')._(' | Cellove.com'))
  end
end
