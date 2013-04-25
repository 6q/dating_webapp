class FlatPagesController < ApplicationController
  skip_before_filter :authenticate_user!

  def legal
  end

  def what
    @sidebar = true
  end

  def privacy_policy
  end

  def terms_conditions
  end

  def usage
  end

  def new_contact_form
    @contact_form = ContactForm.new
  end

  def contact_form
    c = ContactForm.new(params[:contact_form])
    c.deliver
    redirect_to new_contact_form_path
  end

  def media_press
  end

  def tv_spot
    @sidebar = true
    @videos = true
    id = params[:id]

    render "tv_spot_#{id}"
  end

  def how_it_works
  end

  def raise_popularity
    @sidebar = true
  end

  def matchmakers
    @sidebar = true
  end
end

