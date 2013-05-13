class DashboardController < ApplicationController
  layout "logged_in"
  skip_before_filter :matchmaker_user
end
