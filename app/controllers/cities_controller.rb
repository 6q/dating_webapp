class CitiesController < ApplicationController
  COUNTRIES = 
  def index
  end

  def countries
    render do |format|
      format.json { CountrySelect::COUNTRIES.to_json }
    end
  end
end
