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
    mail(:to => user.email, :subject => "Welcome to Cellove")
    prevent_delivery_to_unconfirmed
  end

  def invite_user(user, email_address, invitation_code)
    @user = user
    @url = new_user_registration_url + '?invitation_code=' + invitation_code
    mail(:to => email_address, :subject => user.name + " invites you to Cellove")
    prevent_delivery_to_unconfirmed
  end

  def invite_celestino(user, email_address, invitation_code)
    @user = user
    @url = new_user_registration_url + '?invitation_code=' + invitation_code
    mail(:to => email_address, :subject => user.name + " invites you to Cellove")
    prevent_delivery_to_unconfirmed
  end

  # Email notifications
  def receive_message(sender, recipient)
    @sender = sender
    @recipient = recipient
    mail(:to => @recipient.email, :subject => "New message")
    prevent_delivery_to_unconfirmed
  end

  def profile_visit(visitor, visited)
    @sender = visitor
    @recipient = visited
    mail(:to => @recipient.email, :subject => "New profile visit")
    prevent_delivery_to_unconfirmed
  end

  def like(sender, recipient)
    @sender = sender
    @recipient = recipient
    mail(:to => @recipient.email, :subject => "New like")
    prevent_delivery_to_unconfirmed
  end

  def star_rating(sender, recipient)
    @sender = sender
    @recipient = recipient
    mail(:to => @recipient.email, :subject => "New star rating")
    prevent_delivery_to_unconfirmed
  end

  def celestino_recommendation(sender, recipient)
    @sender = sender
    @recipient = recipient
    mail(:to => @recipient.email, :subject => "New celestino recommendation")
    prevent_delivery_to_unconfirmed
  end
end
