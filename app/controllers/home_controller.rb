class HomeController < ApplicationController
  skip_before_filter :authenticate_user!
  skip_before_filter :matchmaker_user

  def index
    #@users = User.all
  end
end
