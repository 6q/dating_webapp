class UserMailer < ActionMailer::Base
  default from: "Cellove <noreply@cellove.com>"

  def prevent_delivery_to_unconfirmed
    if (@user && !@user.confirmed?) || (@recipient && !@recipient.confirmed?)
      mail.perform_deliveries = false
    end
  end
  private :prevent_delivery_to_unconfirmed

  def welcome_email(user)
    @user = user
    mail(:to => user.email, :subject => _('Bienvenido a Cellove'))
    prevent_delivery_to_unconfirmed
  end

  def invite_user(user, email_address, invitation_code)
    @user = user
    @url = new_user_registration_url + '?invitation_code=' + invitation_code
    mail(:to => email_address, :subject => (_('%{name} te invita a Cellove') % {name: user.name})
    prevent_delivery_to_unconfirmed
  end

  def invite_celestino(user, email_address, invitation_code)
    @user = user
    @url = new_user_registration_url + '?invitation_code=' + invitation_code
    mail(:to => email_address, :subject => (_('%{name} te invita a Cellove') % {name: user.name})
    prevent_delivery_to_unconfirmed
  end

  # Email notifications
  def receive_message(sender, recipient)
    @sender = sender
    @recipient = recipient
    mail(:to => @recipient.email, :subject => _('Nuevo mensaje'))
    prevent_delivery_to_unconfirmed
  end

  def profile_visit(visitor, visited)
    @sender = visitor
    @recipient = visited
    mail(:to => @recipient.email, :subject => _('Nueva visita de perfil'))
    prevent_delivery_to_unconfirmed
  end

  def like(sender, recipient)
    @sender = sender
    @recipient = recipient
    mail(:to => @recipient.email, :subject => _('Nuevo me gusta'))
    prevent_delivery_to_unconfirmed
  end

  def star_rating(sender, recipient)
    @sender = sender
    @recipient = recipient
    mail(:to => @recipient.email, :subject => _('Nuevo hacemos buena pareja'))
    prevent_delivery_to_unconfirmed
  end

  def celestino_recommendation(sender, recipient)
    @sender = sender
    @recipient = recipient
    mail(:to => @recipient.email, :subject => _('Nueva recomendación'))
    prevent_delivery_to_unconfirmed
  end
end
