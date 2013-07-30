class ActivitiesController < ApplicationController
  before_filter :check_current_subject_in_conversation, only: [:new, :create]

  def new
  end

  def create
    unless @conversation
      @recipient = User.find(params[:recipient]) if params[:recipient].present?
      @receipt = current_user.send_message(@recipient, _('Te propongo esta actividad'), params[:activity][:body].blank? ? _('Sin mensaje') : params[:activity][:body][0..10])
      @conversation = @receipt.conversation
    end
    @activity = @conversation.build_activity(params[:activity])
    @activity.sender_id = current_user.id

    if @activity.save
      redirect_to @conversation
    end
  end

  def reject
    @activity = Activity.find(params[:activity_id])
    @activity.status = :rejected

    if @activity.save
      redirect_to @activity.conversation
    end
  end

  private
    def check_current_subject_in_conversation
      @conversation = Conversation.find_by_id(params[:conversation_id])
    end

end
