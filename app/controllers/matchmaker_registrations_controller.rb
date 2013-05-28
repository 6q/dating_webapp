class MatchmakerRegistrationsController < Devise::RegistrationsController
  skip_before_filter :matchmaker_user
  before_filter :require_no_authentication

  # Overrode this method to be able to test controller ~.~
  # See test/controllers/matchmaker_registrations_controller_test.rb
  def after_sign_up_path_for(resource)
    super(resource)
  end

  def create
    if params[:matchmaker] && invitation_code = params[:matchmaker][:invitation_code]
      params[:matchmaker].delete :invitation_code
      invitation = Invitation.where("invitation_code = ?", invitation_code).first
      if !invitation.nil? && !invitation.accepted
        invitation.accepted = true
        # Give referring user extra cellove points.
        referring_user = invitation.user
        referring_user.add_to_cellove_index(User::CELLOVE_RECOMMENDED_USER)
        invitation.save
      end
    end

    @user = User.new(params[:matchmaker])
    if @user.save
      @user.add_role :matchmaker
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
