#encoding: utf-8
class ProfilesController < ApplicationController
  layout 'logged_in'
  skip_before_filter :matchmaker_user
  before_filter :skip_password_attribute, only: :update

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
    # Amount in cents
    @amount = 499

    customer = Stripe::Customer.create(
      :email => current_user.email,
      :description => 'Cellove monthly payment from ' + current_user.email,
      :card  => params[:stripeToken],
      :plan  => 'CELLOVE-VIP'
    )

    current_user.upgrade_to_premium # TODO: Add Stripe information
    flash[:success] = _('Actualización a usuari@ VIP se ha realizado correctamente')
    redirect_to root_path

  rescue Stripe::CardError => e
    flash[:error] = _('Oops!') + e.message
    redirect_to pay_path
  end

  def pay_cancellation
    # TODO: Cancel Stripe subscription
    # unless customer_id.nil?
    #   customer = Stripe::Customer.retrieve(customer_id)
    #   unless customer.nil? or customer.respond_to?('deleted')
    #     if customer.subscription.status == 'active'
    #       customer.cancel_subscription
    #     end
    #   end
    # end
    current_user.remove_premium
    flash[:success] = _('Cancelación de usuari@ VIP se ha realizado correctamente')
    redirect_to root_path

  rescue Stripe::StripeError => e
    flash[:error] = _('Oops!') + e.message
    redirect_to pay_path
  end

  private
    def skip_password_attribute
      if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
        params[:user].except!(:password, :password_confirmation)
      end
    end
end
