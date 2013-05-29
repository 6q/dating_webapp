class UserMailer < ActionMailer::Base
  default from: "noreply@cellove.com"

  def welcome_email(user)
    @user = user
    @url  = "http://example.com/login"
    mail(:to => user.email, :subject => "Welcome to My Awesome Site")
  end

  def invite_user(user, email_address, invitation_code)
    @user = user
    @url = new_user_registration_url + '?invitation_code=' + invitation_code
    mail(:to => email_address, :subject => user.name + " invites you to Cellove")
  end

  def invite_celestino(user, email_address, invitation_code)
    @user = user
    @url = new_user_registration_url + '?invitation_code=' + invitation_code
    mail(:to => email_address, :subject => user.name + " invites you to Cellove")
  end

  # Email notifications
  def receive_message(sender, recipient)
    @sender = sender
    @recipient = recipient
    mail(:to => @recipient.email, :subject => "New message")
  end

  def profile_visit(visitor, visited)
    @sender = sender
    @recipient = recipient
    mail(:to => @recipient.email, :subject => "New profile visit")
  end

  def like(sender, recipient)
    @sender = sender
    @recipient = recipient
    mail(:to => @recipient.email, :subject => "New like")
  end

  def star_rating(sender, recipient)
    @sender = sender
    @recipient = recipient
    mail(:to => @recipient.email, :subject => "New star rating")
  end

  def celestino_recommendation(sender, recipient)
    @sender = sender
    @recipient = recipient
    mail(:to => @recipient.email, :subject => "New celestino recommendation")
  end
end
