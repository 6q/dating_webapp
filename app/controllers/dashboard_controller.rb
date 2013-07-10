class DashboardController < ApplicationController
  layout "logged_in"

  def show
    @search = User.search
  end

  def update_radius
    if params[:radius] && params[:partial]
      radius = params[:radius].to_i
      radius += 100
      partial = params[:partial].underscore
      template = render_to_string(partial: partial, formats: [:html], locals: { radius: radius })

      respond_to do |format|
        format.json { render json: { template: template } }
      end
    end
  end
end
