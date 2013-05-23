class UsersController < ApplicationController
  skip_before_filter :authenticate_user!, only: :view
  skip_before_filter :matchmaker_user, only: [:matchmaker_become_user]
  
  layout 'logged_in'

  after_filter :user_visit, only: [:show]
  before_filter :set_visit_seen, only: [:hits]

  def index
    @users = User.all
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
    render 'settings', layout: "logged_in"
  end

  def nice_couple
    render 'nice_couple', layout: "logged_in"
  end

  # Matchmaker routes
  def be_matchmaker
    @recommendation = Recommendation.new
    @characteristic = Characteristic.new
    render 'be_matchmaker', layout: "logged_in"
  end

  def matchmaker_become_user
    render 'matchmaker_become_user', layout: "logged_in"
  end

  def my_matchmakers
    render 'my_matchmakers', layout: "logged_in"
  end

  # Interaction routes
  def likes
    render 'likes', layout: "logged_in"
  end

  def likes_of_mine
    render 'likes_of_mine', layout: "logged_in"
  end

  def hits
    render 'hits', layout: "logged_in"
  end

  def cellove_index
    render 'cellove_index', layout: "logged_in"
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
