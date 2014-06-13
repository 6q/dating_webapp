#encoding: utf-8
class ProfilesController < ApplicationController
  layout 'logged_in'
  skip_before_filter :matchmaker_user
  before_filter :skip_password_attribute, only: :update
  skip_before_filter :check_if_disabled

  def show
    @user = current_user
    if @user.has_role?(:matchmaker)
      render 'matchmaker_show'
    else
      render 'show'
    end
  end

  def images
    @user = current_user
    render :partial => 'profiles/pictures_needed', :formats => [:html]
  end

  def update
    @user = current_user
    @user.assign_attributes(params[:user])
    if @user.save
      session[:best_suited_near_me] = nil
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

        flash[:alert] = _('No se ha podido guardar.')
        render 'matchmaker_show'
      else
        flash[:alert] = _('No se ha podido guardar.')
        render 'show'
      end
    end
  end

  def pay
  end

  def pay_confirmation
    if current_user.upgrade_to_premium params[:stripeToken]
      flash[:success] = _('Actualización a usuari@ VIP se ha realizado correctamente')
      redirect_to root_path
    else
      flash[:error] = _('Actualización a usuari@ VIP No ha sido posible')
      redirect_to pay_path
    end
  end

  def pay_cancellation
    if current_user.remove_premium
      flash[:success] = _('Cancelación de usuari@ VIP se ha realizado correctamente')
      redirect_to root_path
    else
      flash[:error] = _('Cancelación de usuari@ VIP No ha sido posible')
      redirect_to pay_path
    end
  end

  private
    def skip_password_attribute
      if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
        params[:user].except!(:password, :password_confirmation)
      end
    end
end
