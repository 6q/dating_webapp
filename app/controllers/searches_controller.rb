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
    # Construct and redirect to constructed search path
    redirect_to search.search_path
  end

end
