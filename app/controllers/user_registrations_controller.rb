class UserRegistrationsController < Devise::RegistrationsController
  def create
    @user = User.new(params[:user])

    if @user.save
      @user.add_role :regular_user

      Characteristic.create(user_id: @user.id, creator_id: @user.id)

      if @user.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_up(:user, @user)
        respond_with @user, :location => after_sign_up_path_for(@user)
      else
        set_flash_message :notice, :"signed_up_but_#{@user.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with @user, :location => after_inactive_sign_up_path_for(@useer)
      end
    else
      clean_up_passwords @user
      respond_with @user
    end
  end
end
