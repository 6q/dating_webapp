class FlatPagesController < ApplicationController
  def page_with_no_layout
    flat_page = "flat_pages/#{params[:id].gsub('-', '_')}"
    render :template => flat_page, :layout => 'landing'
  end
end
