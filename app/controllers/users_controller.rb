#encoding: utf-8
class UsersController < ApplicationController
  skip_before_filter :authenticate_user!, only: :view
  skip_before_filter :matchmaker_user, only: [:matchmaker_become_user]

  layout 'logged_in', :except => 'view'

  after_filter :user_visit, only: [:show]
  before_filter :set_visit_seen, only: [:hits]
  before_filter :set_likes_seen, only: [:likes]
  before_filter :set_rates_seen, only: [:nice_couple]

  def index
    search_and_order

    if session[:best_suited_near_me].present?
      @best_suited_near_me = User.find(session[:best_suited_near_me])
    else
      @best_suited_near_me = current_user.best_suited_near_me
      session[:best_suited_near_me] = @best_suited_near_me.map(&:id)
    end

    if special = params[:special]
      @users = Kaminari.paginate_array(current_user.retrieve_users(500, special.to_sym)).page(params[:page])
    else
      @users = @search.result.page(params[:page]).uniq
    end

    @cellove_search = Search.new
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    authorize! :update, @user, :message => 'Not authorized as an administrator.'
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user], :as => :admin)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end

  def destroy
    authorize! :destroy, @user, :message => 'Not authorized as an administrator.'
    user = User.find(params[:id])
    unless user == current_user
      user.destroy
      redirect_to users_path, :notice => "User deleted."
    else
      redirect_to users_path, :notice => "Can't delete yourself."
    end
  end

  def view
    @users = User.with_role(:user).last(7)
  end

  def settings
  end


  # Matchmaker routes
  def be_matchmaker
    @recommendation = Recommendation.new
    @characteristic = Characteristic.new
  end

  def matchmaker_become_user
    @geocoder = Geocoder.search(request.ip).first
  end

  def my_matchmakers
    @confirmed_recommenders = current_user.confirmed_recommenders.page(params[:page])
    @unconfirmed_recommenders = current_user.unconfirmed_recommenders.page(params[:page])
    @invitation = Invitation.new
  end

  # Interaction routes
  def nice_couple
    nc = User.nice_couple(current_user).pluck(:id)
    search_and_order(nc)
    @users = @search.result.page(params[:page])
  end

  def likes
    @users = Kaminari::paginate_array(User.people_who_like_me(current_user, params[:order])).page(params[:page])
  end

  def likes_of_mine
    @users = Kaminari::paginate_array(User.people_i_like(current_user, params[:order])).page(params[:page])
  end

  def hits
    @users = Kaminari::paginate_array(User.all_visitors(current_user, params[:order])).page(params[:page])
  end

  def cellove_index
    #TODO
    render 'cellove_index'
  end

  def general_settings
    if current_user.has_role?(:premium_user)
      if current_user.general_settings.update_attributes(params[:general_setting], {as: :premium_user})
        flash[:success] = _('Configuración actualizada')
      else
        flash[:error] = _('Oops!')
      end
    else
      if current_user.general_settings.update_attributes(params[:general_setting])
        flash[:success] = _('Configuración actualizada')
      else
        flash[:error] = _('Oops!')
      end
    end
    redirect_to settings_path
  end

  def save_background
    current_user.background = params[:background]
    current_user.save
    respond_to do |format|
      format.json { render json: current_user.background.to_json }
    end
  end

  def get_background
    respond_to do |format|
      format.json { render json: current_user.background.to_json }
    end
  end

  private
    def user_visit
      if @user && current_user != @user
        current_user.visited(@user)
        @user.add_to_cellove_index(User::CELLOVE_USER_VISIT)
      end
    end

    def set_visit_seen
      current_user.set_all_visits_seen
    end

    def set_likes_seen
      current_user.set_all_likes_seen
    end

    def set_rates_seen
      current_user.set_all_rates_seen
    end

    def search_and_order(in_filter = nil)
      distance = params[:distance] || User::DEFAULT_SEARCH_DISTANCE
      hidden_users = User
            .where("users.id NOT IN (?)", current_user.get_all_invisible_to_me)
            .where("users.gender = ?", current_user.matching_gender)
            .where("users.lf_gender = ?", current_user.gender)

      in_filter = [0] if !in_filter.nil? && in_filter.empty?
      if params[:q]
        params[:q] = params[:q].merge(id_in: in_filter)
        if params[:q][:years_lteq] == params[:q][:years_gteq]
          params[:q][:years_start_gteq] = params[:q][:years_lteq]
          params[:q][:years_end_lteq] = params[:q][:years_gteq]
          params[:q].except!(:years_lteq)
          params[:q].except!(:years_gteq)
        end
      else
        params[:q] = {}
        params[:q][:id_in] = in_filter
      end

      hidden_users.tap do |hu|
        case params[:action]
        when 'nice_couple'
          ordered = hu.joins(:rates).order('rates.created_at DESC').uniq
        else
          ordered = hu
        end
        center = []

        center << params[:city] if params[:city].present?
        center << params[:postal_code] if params[:q][:postal_code].present?

        @search = ordered.near(center.empty? ? current_user : center.join(','), distance.to_i, { :units => :km, :sort => :distance }).search(params[:q])
        if @search.sorts.empty?
          @search.sorts = ['pictures_main desc', 'distance asc']
        end
      end

      params[:q].except!(:id_in)
      if params[:q][:years_start_gteq]
        params[:q][:years_lteq] = params[:q][:years_start_gteq]
        params[:q][:years_gteq] = params[:q][:years_start_gteq]
        params[:q].except!(:years_start_gteq)
        params[:q].except!(:years_end_lteq)
      end
    end
end
