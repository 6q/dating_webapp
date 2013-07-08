#encoding: utf-8
class ProfilesController < ApplicationController
  layout 'logged_in'
  skip_before_filter :matchmaker_user
  before_filter :skip_password_attribute, only: :update

  def show
    @user = current_user
    if @user.has_role?(:matchmaker)
      @recommendation = Recommendation.new
      @characteristic = Characteristic.new

      render 'matchmaker_show'
    else
      render 'show'
    end
  end

  def update
    @user = current_user
    @user.assign_attributes(params[:user])
    if @user.save
      if @user.has_role?(:matchmaker)
        @recommendation = Recommendation.new
        @characteristic = Characteristic.new

        flash[:success] = _('Cambios guardados.')
        render 'matchmaker_show'
      else
        flash[:success] = _('Cambios guardados.')
        render 'show'
      end
    else
      if @user.has_role?(:matchmaker)
        @recommendation = Recommendation.new
        @characteristic = Characteristic.new

        flash[:success] = _('No se ha podido guardar.')
        render 'matchmaker_show'
      else
        flash[:success] = _('No se ha podido guardar.')
        render 'show'
      end
    end
  end

  def pay
  end

  def pay_confirmation
    if true # Do some token/payment/what ever check here
      current_user.upgrade_to_premium
      flash[:success] = _('Actualización a usuari@ premium se ha realizado correctamente')
    else
      flash[:error] = _('Oops!')
    end
    redirect_to root_path
  end

  private
    def skip_password_attribute
      if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
        params[:user].except!(:password, :password_confirmation)
      end
    end
end
