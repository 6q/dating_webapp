class DashboardController < ApplicationController
  layout "logged_in"

  def show
    @best_suited_near_me = current_user.best_suited_near_me

    could_interest_me = current_user.could_interest_me.sample(20)
    @could_interest_me = Kaminari.paginate_array(could_interest_me).page(params[:page]).per(5)
    session[:could_interest_me] = could_interest_me.map(&:id)

    best_index = current_user.best_index.sample(20)
    @best_index = Kaminari.paginate_array(best_index).page(params[:page]).per(5)
    session[:best_index] = best_index.map(&:id)

    new_users_near_me = current_user.new_users_near_me.sample(20)
    @new_users_near_me = Kaminari.paginate_array(new_users_near_me).page(params[:page]).per(5)
    session[:new_users_near_me] = new_users_near_me.map(&:id)

    @search = User.search
  end

  def paginate_users
    if params[:page] && params[:partial]

      instance_variable_set("@#{params[:partial]}", Kaminari.paginate_array(User.find(session[params[:partial].to_sym])).page(params[:page]).per(5))

      template = render_to_string(partial: params[:partial], formats: [:html])

      respond_to do |format|
        format.json { render json: { id: params[:partial].dasherize, template: template } }
      end
    end
  end
end
