class ActivitiesController < ApplicationController
  before_filter :check_current_subject_in_conversation, only: [:new, :create]

  def new
  end

  def create
    @activity = @conversation.build_activity(params[:activity])

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

    if @conversation.nil? or !@conversation.is_participant?(current_user)
      redirect_to conversations_path(:box => @box)
    return
    end
  end

end