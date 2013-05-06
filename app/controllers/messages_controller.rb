class MessagesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_mailbox, :get_box

  def index
    redirect_to conversations_path(:box => @box)
  end

  # GET /messages/1
  # GET /messages/1.xml
  def show
    if @message = Message.find_by_id(params[:id]) and @conversation = @message.conversation
      if @conversation.is_participant?(@actor)
        redirect_to conversation_path(@conversation, :box => @box, :anchor => "message_" + @message.id.to_s)
      return
      end
    end
    redirect_to conversations_path(:box => @box)
  end

  # GET /messages/new
  # GET /messages/new.xml
  def new
    if params[:receiver].present?
      @recipient = User.find(params[:receiver])
      return if @recipient.nil?
    end
  end

  # GET /messages/1/edit
  def edit

  end

  # POST /messages
  # POST /messages.xml
  def create
    @recipient = User.find(params[:recipient]) if params[:recipient].present? 

    @receipt = current_user.send_message(@recipient, params[:body], params[:subject])
    if (@receipt.errors.blank?)
      @conversation = @receipt.conversation
      flash[:success] = _('Mensaje enviado')
    else
      render :action => :new
    end
  end

  # PUT /messages/1
  # PUT /messages/1.xml
  def update

  end

  # DELETE /messages/1
  # DELETE /messages/1.xml
  def destroy

  end

  private

  def get_mailbox
    @mailbox = current_user.mailbox
  end

  def get_box
    if params[:box].blank? or !["inbox","sentbox","trash"].include?params[:box]
      @box = "inbox"
    return
    end
    @box = params[:box]
  end

end
