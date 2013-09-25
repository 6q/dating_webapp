class DashboardController < ApplicationController
  layout "logged_in"
  before_filter :set_vars

  def show
    @search = User.search
  end

  def paginate_users
    if params[:page] && params[:partial]
      template = render_to_string(partial: params[:partial], formats: [:html])

      respond_to do |format|
        format.json { render json: { template: template } }
      end
    end
  end

  def set_vars
    @best_suited_near_me = current_user.best_suited_near_me
    @could_interest_me = Kaminari.paginate_array(current_user.could_interest_me).page(params[:page]).per(5)
    @best_index = Kaminari.paginate_array(current_user.best_index).page(params[:page]).per(5)
    @new_users_near_me = Kaminari.paginate_array(current_user.new_users_near_me).page(params[:page]).per(5)
  end
  private :set_vars
end
