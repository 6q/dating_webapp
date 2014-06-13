class DashboardController < ApplicationController
  layout "logged_in"

  before_filter :check_if_must_complete_fields, :only => :show
  before_filter :skip_password_attribute, only: :update_complete_fields
  before_filter :check_if_disabled
  skip_before_filter :check_if_disabled

  # moure això a l'application_controller quan tinguem el formulari de usuari invitat apunt
  # obligar-lo a omplir nom i cognoms i dades de localització per evitar errors a l'app
  # before_filter :is_invited_user?

  def show
    @best_suited_near_me = current_user.best_suited_near_me(6)
    @search = User.search
    session[:shown_ids] = @best_suited_near_me.map(&:id) # Needed because of ajax loading
  end

  def show_users
    if params[:partial]

      case params[:partial]
      when "could_interest_me"
        could_interest_me           = current_user.could_interest_me(20, session[:shown_ids]).sample(20)
        @could_interest_me          = Kaminari.paginate_array(could_interest_me).page(params[:page]).per(5)
        session[:could_interest_me] = could_interest_me.map(&:id)
        session[:shown_ids]        += session[:could_interest_me]
      when "best_index"
        best_index            = current_user.best_index(20, session[:shown_ids]).sample(20)
        @best_index           = Kaminari.paginate_array(best_index).page(params[:page]).per(5)
        session[:best_index]  = best_index.map(&:id)
        session[:shown_ids]  += session[:best_index]
      when "new_users_near_me"
        new_users_near_me           = current_user.new_users_near_me(20, session[:shown_ids]).sample(20)
        @new_users_near_me          = Kaminari.paginate_array(new_users_near_me).page(params[:page]).per(5)
        session[:new_users_near_me] = new_users_near_me.map(&:id)
        session[:shown_ids]        += session[:new_users_near_me]
      else
        return nil
      end

      render :partial => params[:partial], :formats => [:html]
    end
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

  def complete_fields
    @user = current_user
  end

  def update_complete_fields
    @user = current_user
    @user.assign_attributes(params[:user])
    if @user.save
      flash[:success] = _('Cambios guardados.')
      redirect_to profile_url
    else
      flash[:alert] = _('No se ha podido guardar.')
      render 'complete_fields'
    end
  end

  private

  def check_if_must_complete_fields
    if current_user && !current_user.has_all_fields?
      redirect_to complete_fields_url, :alert => _('Debes completar tus datos para poder usar Cellove') and return
    end
  end

  def skip_password_attribute
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].except!(:password, :password_confirmation)
    end
  end

  # moure això a l'application_controller quan tinguem el formulari de usuari invitat apunt
  # obligar-lo a omplir nom i cognoms i dades de localització per evitar errors a l'app

  #def is_invited_user?
  #  if current_user.roles.include?(Role.find_by_name("invited_user")) # no és correcte, hauriem de mirar si té nom i dades de localització
  #    redirect_to profile_url
  #  end
  #end
end
