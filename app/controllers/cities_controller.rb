class CitiesController < ApplicationController
  def index
  end

  def countries
    @countries = Country.all

    render do |format|
      format.json { @countries.to_json }
    end
  end
end
