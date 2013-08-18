class FlatPagesController < ApplicationController
  skip_before_filter :authenticate_user!
  before_filter :set_sidebar, only: [:what, :how_it_works, :raise_popularity, :matchmakers, :tv_spot]

  def set_sidebar
    @sidebar = true
  end
  private :set_sidebar

  def new_contact_form
    @contact_form = ContactForm.new
  end

  def contact_form
    c = ContactForm.new(params[:contact_form])
    c.deliver
    redirect_to new_contact_form_path
  end

  def tv_spot
    @videos = true
    id = params[:id]

    render "tv_spot_#{id}"
  end
end

