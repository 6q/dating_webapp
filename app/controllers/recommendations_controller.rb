#encoding: utf-8
class RecommendationsController < ApplicationController
  skip_before_filter :matchmaker_user, only: [:create]
  before_filter :correct_user, only: [:accept, :deny]
  after_filter :add_to_cellove_index, only: [:accept]
  layout 'logged_in'
  EMAIL_REGEX = /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/

  def create
    if params[:user] &&
        params[:user][:name] && 
        params[:user][:email] && 
        params[:user][:email] =~ EMAIL_REGEX
      @recommendation = current_user.recommendations.build(params[:recommendation])

      # We've got a valid name and email. Now look for the current user by email address
      user = User.where("email = ?", params[:user][:email]).first
      if user.nil?
        # User was not found. Create and invite a new one,
        # without validations (we have no password etc. yet)
        user = User.new_invitee(params[:user])
        user.save(validate: false)
      end

      @recommendation.user_id = user.id
      if @recommendation.save
        @characteristic = @recommendation.build_characteristic(params[:characteristic])
        @characteristic.user_id = user.id
        @characteristic.creator_id = current_user.id
        @characteristic.save
        flash[:success] = _('Recommendación enviada')
        redirect_to be_matchmaker_path
      else
        flash[:error] = _('Datos incorrectos o faltantes')
        #@recommendation = Recommendation.new(params[:recommendation])
        #@characteristic = Characteristic.new(params[:characteristic])
        #render 'users/be_matchmaker'
        redirect_to be_matchmaker_path
      end
    else
      flash[:error] = _('Datos incorrectos o faltantes')
      #@recommendation = Recommendation.new(params[:recommendation])
      #@characteristic = Characteristic.new(params[:characteristic])
      #render 'users/be_matchmaker'
      redirect_to be_matchmaker_path
    end
  end

  def accept
    # @recommendation is found in correct_user filter
    if @recommendation
      @recommendation.confirmed = true
      @recommendation.save
      flash[:success] = _('Recommendación acceptada')
    end
    redirect_to my_matchmakers_path
  end

  def deny
    # @recommendation is found in correct_user filter
    if @recommendation
      @recommendation.denied = true
      @recommendation.save
      flash[:success] = _('Recommendación negada')
    end
    redirect_to my_matchmakers_path
  end

  private
    def correct_user
      @recommendation = Recommendation.find(params[:recommendation_id])
      redirect_to root_path unless @recommendation.user_id == current_user.id
    end

    # Callback for accept method
    def add_to_cellove_index
      case @recommendation.relationship
      when 1 # Ex Pareja
        current_user.add_to_cellove_index(User::CELLOVE_CELESTINO_EX_PARTNER)
      when 2
        current_user.add_to_cellove_index(User::CELLOVE_CELESTINO_SPECIAL_FRIEND)
      when 3
        current_user.add_to_cellove_index(User::CELLOVE_CELESTINO_FRIEND)
      when 4
        current_user.add_to_cellove_index(User::CELLOVE_CELESTINO_FAMILY)
      else
        # BEUP. Wrong.
      end
    end
  
end
