class ConversationsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_mailbox, :get_box
  before_filter :check_current_subject_in_conversation, :only => [:show, :update, :destroy]

  layout "logged_in"
  
  def index
    if params[:activities] == 'show' 
           @conversations_inbox = @mailbox.inbox.includes(:activity).reject { |i| i.activity.nil? }
      @conversations_inbox = Kaminari.paginate_array(@conversations_inbox).page(params[:page]).per(9)
      @conversations_sentbox = @mailbox.sentbox.includes(:activity).reject { |i| i.activity.nil? }
      @conversations_sentbox = Kaminari.paginate_array(@conversations_sentbox).page(params[:page]).per(9)
      @conversations_trash = @mailbox.trash.includes(:activity).reject { |i| i.activity.nil? }
      @conversations_trash = Kaminari.paginate_array(@conversations_trash).page(params[:page]).per(3)
    else 
      if params[:q] && params[:q][:s] == 'prop_actividad asc'
        @conversations_inbox = @mailbox.inbox.joins('LEFT OUTER JOIN activities ON activities.conversation_id = conversations.id').reorder('activities.conversation_id DESC').page(params[:page]).per(9)
      else
        @conversations_inbox = @mailbox.inbox.page(params[:page]).per(9)
      end
      @conversations_sentbox = @mailbox.sentbox.page(params[:page]).per(9)
      @conversations_trash = @mailbox.trash.page(params[:page]).per(9)
    end
     
    @search = User.search(params[:q])

    respond_to do |format|
      format.html { render partial: 'conversations', locals: { conversations: @conversations_sentbox } if request.xhr? }
    end
  end

  def show
    @conversations_inbox = @mailbox.inbox.page(params[:page]).per(9)
    @conversations_sentbox = @mailbox.sentbox.page(params[:page]).per(9)
    @conversations_trash = @mailbox.trash.page(params[:page]).per(9)
    @search = User.search(params[:q])
    
    if @box.eql? 'trash'
      @receipts = @mailbox.receipts_for(@conversation).trash
    else
      @receipts = @mailbox.receipts_for(@conversation).not_trash
    end
    render :action => :show
    @receipts.mark_as_read
  end

  def new

  end

  def edit

  end

  def create

  end

  def update
    if params[:untrash].present?
      @conversation.untrash(current_user)
    end

    if params[:accept_activity]
      @conversation.activity.accept! if @conversation.activity
    end

    last_receipt = @conversation.messages.reject {|m| m.sender == current_user}.first.receipts.sentbox.first
    @receipt = current_user.reply_to_sender(last_receipt, params[:message][:body])

    if @box.eql? 'trash'
      @receipts = @mailbox.receipts_for(@conversation).trash
    else
      @receipts = @mailbox.receipts_for(@conversation).not_trash
    end
    redirect_to :action => :show
    @receipts.mark_as_read
  end

  def destroy
    @conversation.move_to_trash(current_user)

    respond_to do |format|
      format.html {
        if params[:location].present? and params[:location] == 'conversation'
          redirect_to conversations_path(:box => :trash)
  else
          redirect_to conversations_path(:box => @box,:page => params[:page])
  end
      }
      format.js {
        if params[:location].present? and params[:location] == 'conversation'
          render :js => "window.location = '#{conversations_path(:box => @box,:page => params[:page])}';"
  else
          render 'conversations/destroy'
  end
      }
    end
  end

  private

  def get_mailbox
    @mailbox = current_user.mailbox
  end

  def get_box
    if params[:box].blank? or !["inbox","sentbox","trash"].include?params[:box]
      params[:box] = 'inbox'
    end

    @box = params[:box]
  end

  def check_current_subject_in_conversation
    @conversation = Conversation.find_by_id(params[:id])

    if @conversation.nil? or !@conversation.is_participant?(current_user)
      redirect_to conversations_path(:box => @box)
    return
    end
  end

end
