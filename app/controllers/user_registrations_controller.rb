class UserRegistrationsController < Devise::RegistrationsController
  skip_before_filter :require_no_authentication, only: :update
  skip_before_filter :matchmaker_user
  skip_before_filter :check_if_must_complete_fields

  # Overrode this method to be able to test controller ~.~
  # See test/controllers/user_registrations_controller_test.rb
  def new
    @geocoder = Geocoder.search(request.env["HTTP_CF_CONNECTING_IP"]).first
    super
  end

  def after_sign_up_path_for(resource)
    super(resource)
  end

  def create
    if params[:user] && params[:user][:invitation_code]
      # User was invited, probably by a celestino
      invitation_code = params[:user][:invitation_code]
      params[:user].delete :invitation_code
      @user = User.where('invitation_code = ?', invitation_code).first
      if @user
        @user.assign_attributes(params[:user])
        register_user
        if @user.has_role?(:regular_user)
          @user.remove_role :invited_user
        end
      else
        invitation = Invitation.where("invitation_code = ?", invitation_code).first
        if !invitation.nil? && !invitation.accepted
          invitation.accepted = true
          # Give referring user extra cellove points.
          referring_user = invitation.user
          referring_user.add_to_cellove_index(User::CELLOVE_RECOMMENDED_USER)
          invitation.save
        end
        @user = User.new(params[:user])
        register_user(params[:picture])
      end
    else
      @user = User.new(params[:user])
      register_user(params[:picture])
    end
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

  def destroy
    resource.soft_delete
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    set_flash_message :notice, :destroyed if is_navigational_format?
    respond_with_navigational(resource){ redirect_to after_sign_out_path_for(resource_name) }
  end

  def recover
    current_user.update_attribute(:deleted_at, nil)
    redirect_to profile_path
  end

  private

    def register_user(picture = nil)
      @user.add_role :regular_user
      if @user.save
        Characteristic.create(user_id: @user.id, creator_id: @user.id)
        GeneralSetting.create(user_id: @user.id)

        if session[:registration_image]
          @user.pictures << Picture.find(session[:registration_image])
        elsif !picture.empty? # From Facebook or other social networks
          @picture        = Picture.new(image: Dragonfly[:images].fetch_url(picture))
          @picture.image  = @picture.image.thumb("500x500").tempfile
          @picture.main   = true
          @user.pictures << @picture if @picture.save
        end
        session[:registration_image] = nil

        UserMailer.welcome_email(@user).deliver
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
