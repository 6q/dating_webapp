#encoding: utf-8
class SearchesController < ApplicationController

  layout 'logged_in'

  def create
    search = current_user.searches.build(params[:search])
    if search.save
      flash[:success] = _('Búsqueda guardada')
    else
      flash[:error] = _('Oops!')
    end
    redirect_to search.search_path
  end

  def destroy
    # Delete search.
    Search.find(params[:id]).destroy
    flash[:success] = _('Búsqueda borrada')
    redirect_to search_path
  end

  def show
    search = Search.find(params[:id])
    # Construct and redirect to constructed search path
    redirect_to search.search_path
  end

end
