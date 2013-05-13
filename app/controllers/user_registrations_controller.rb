class UserRegistrationsController < Devise::RegistrationsController
  skip_before_filter :require_no_authentication, only: :update
  skip_before_filter :matchmaker_user

  # Overrode this method to be able to test controller ~.~
  # See test/controllers/user_registrations_controller_test.rb
  def after_sign_up_path_for(resource)
    super(resource)
  end

  def create
    @user = User.new(params[:user])
    register_user
  end

  def update
    if current_user && current_user.has_role?(:matchmaker)
      # Convert matchmaker into regular user
      @user = current_user
      @user.assign_attributes(params[:user])
      register_user
      if @user.has_role?(:regular_user)
        @user.remove_role :matchmaker
      end
    else
      redirect_to root_path
    end
  end

  private

    def register_user
      @user.add_role :regular_user
      if @user.save
        Characteristic.create(user_id: @user.id, creator_id: @user.id)

        if @user.active_for_authentication?
          set_flash_message :notice, :signed_up if is_navigational_format?
          sign_up(:user, @user)
          respond_with @user, :location => after_sign_up_path_for(@user)
        else
          set_flash_message :notice, :"signed_up_but_#{@user.inactive_message}" if is_navigational_format?
          expire_session_data_after_sign_in!
          respond_with @user, :location => after_inactive_sign_up_path_for(@user)
        end
      else
        @user.remove_role :regular_user
        clean_up_passwords @user
        respond_with @user
      end
    end
end
