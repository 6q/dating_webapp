#encoding: utf-8
class UsersController < ApplicationController
  skip_before_filter :authenticate_user!, only: :view
  skip_before_filter :matchmaker_user, only: [:matchmaker_become_user]
  
  layout 'logged_in'
  
  after_filter :user_visit, only: [:show]
  before_filter :set_visit_seen, only: [:hits]

  def index
    distance = params[:distance] || User::DEFAULT_SEARCH_DISTANCE
    hidden_user_ids = current_user.get_all_invisible_to_me

    if params[:q] && params[:q][:s] == "distance asc"
      params[:q].except!(:s)
      @search = User.where("users.id NOT IN (?)", hidden_user_ids)
                    .near(current_user, distance, { :units => :km, :sort => :distance })
                    .search(params[:q])
    elsif params[:q]
      nearbys = current_user.nearbys(distance, { :units => :km }).pluck(:id)
      nearbys = [0] if nearbys.empty?

      params[:q] = params[:q].merge(id_in: nearbys) if params[:q]
      if params[:q][:s] == "recent_interaction asc"
        params[:q].except!(:s)
        @search = User.where("users.id NOT IN (?)", hidden_user_ids).sort_interactions.search(params[:q])
      elsif params[:q][:s] == "prop_actividad asc"
        params[:q].except!(:s)
        @search = User.select("users.*, count(notifications.id) AS activity_count")
                      .joins(:messages => { :conversation => :activity })
                      .group("users.id, notifications.id")
                      .order("activity_count DESC")
                      .where("users.id NOT IN (?)", hidden_user_ids)
                      .search(params[:q])
      else
        @search = User.where("users.id NOT IN (?)", hidden_user_ids).search(params[:q])
      end
      params[:q].except!(:id_in)
    else
      @search = User.search(params[:q])
    end
    if params[:q].nil?
      @users = @search.result(:distinct => true).order('created_at DESC')
    else
      @users = @search.result.page(params[:page])
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
    render 'settings'
  end

  def nice_couple
    @search = User.nice_couple(current_user).search(params[:q])
    @users = @search.result.page(params[:page])
    render 'nice_couple'
  end

  # Matchmaker routes
  def be_matchmaker
    @recommendation = Recommendation.new
    @characteristic = Characteristic.new
    render 'be_matchmaker'
  end

  def matchmaker_become_user
    render 'matchmaker_become_user'
  end

  def my_matchmakers
    @invitation = Invitation.new
    render 'my_matchmakers'
  end

  # Interaction routes
  def likes
    @search = User.people_who_like_me(current_user).search(params[:q])
    @users = @search.result.page(params[:page])
    render 'likes'
  end

  def likes_of_mine
    @search = User.people_i_like(current_user).search(params[:q])
    @users = @search.result.page(params[:page])
    render 'likes_of_mine'
  end

  def hits
    @search = User.all_visitors(current_user).search(params[:q])
    @users = @search.result.page(params[:page])
    render 'hits'
  end

  def cellove_index
    render 'cellove_index'
  end

  def general_settings
    if current_user.general_settings.update_attributes(params[:general_setting])
      flash[:success] = _('Configuración actualizado')
    else
      flash[:error] = _('Oops!')
    end
    redirect_to settings_path
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
end
