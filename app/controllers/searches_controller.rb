class SearchesController < ApplicationController

  layout 'logged_in'

  def create
    search = current_user.searches.build(params[:search])
    if search.save
      flash[:success] = _('Búsqueda guardado')
    else
      flash[:error] = _('Oops!')
    end
    redirect_to user_searches_path(current_user)
  end

  def index
    @searches = current_user.searches
  end

  def destroy
    # Delete search.
    Search.find(params[:id]).destroy
    flash[:success] = _('Búsqueda borrado')
    redirect_to user_searches_path(current_user)
  end

  def show
    search = Search.find(params[:id])
    # Construct search path
    if search.online?
      updated_at_gteq = Time.now
    end
    search_path = users_path(:q => {
      :years_lteq => search.years_lteq,
      :years_gteq => search.years_gteq,
      :town_eq => search.town_eq,
      :postal_code_cont => search.postal_code_cont,
      :description_cont => search.description_cont,
      :pictures_main_eq => search.pictures_main_eq,
      :s => search.sort,
      :updated_at_gteq => updated_at_gteq,
      :smoker_in => search.smoker_in,
      :children_in => search.children_in,
      :height_lteq => search.height_lteq,
      :height_gteq => search.height_gteq,
      :afinity_eq => search.afinity_eq,
      :complexion_eq => search.complexion_eq
    }, :distance => search.distance)
    # Redirect to constructed search path
    redirect_to search_path
  end

end
