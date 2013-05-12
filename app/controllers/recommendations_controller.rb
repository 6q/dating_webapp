class RecommendationsController < ApplicationController
  layout 'logged_in'
  EMAIL_REGEX = /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/

  def create
    @recommendation = current_user.recommendations.build(params[:recommendation])

    if params[:user] &&
        params[:user][:name] && 
        params[:user][:email] && 
        params[:user][:email] =~ EMAIL_REGEX
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
        @characteristic = user.characteristics.create(params[:characteristic])
        @characteristic.creator_id = current_user.id
        @characteristic.save
        redirect_to be_matchmaker_path
      else
        flash[:error] = :"Incorrect or missing data"
        @characteristic = Characteristic.new(params[:characteristic])
        render 'users/be_matchmaker'
      end
    else
      flash[:error] = :"Incorrect or missing data"
      @characteristic = Characteristic.new(params[:characteristic])
      render 'users/be_matchmaker'
    end

  end
  
end
