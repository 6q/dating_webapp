class CitiesController < ApplicationController
  skip_before_filter :authenticate_user!
  skip_before_filter :matchmaker_user

  def index
    @citites = City.where("name LIKE :term", term: "%#{params[:term]}")
    respond_to do |format|
      format.json { render json: @cities }
    end
  end

  def countries
    respond_to do |format|
      format.json { render json: CountrySelect::COUNTRIES }
    end
  end
end
