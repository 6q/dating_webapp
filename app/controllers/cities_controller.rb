class CitiesController < ApplicationController
  skip_before_filter :authenticate_user!
  skip_before_filter :matchmaker_user

  def index
    @cities = City.where(country: (params[:country] || 'es')).where("name LIKE :term", term: "#{params[:term]}%") if params[:term].present?
    respond_to do |format|
      format.json { render json: @cities }
    end
  end
end
