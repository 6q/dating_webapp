class DashboardController < ApplicationController
  layout "logged_in"

  def show
    @search = User.search
  end
end
