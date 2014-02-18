class MessagesController < ApplicationController
  before_filter :require_current_user!
  def index
    @messages = Message.joins(:message_headers).where("message_headers.user_id = 1")
    #includes user?
    #if it says its not read, now set it to is_read
    # if its is_sent last, then italics.
    #limit one per user sent, the one that was created last.

    #in "sent", have it from everyone. just 25 each.
    #have link for destroy.

    #draft.

    #display time it was sent.



    #messages.body #messages.oither
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(params[:message])
    other_id = params[:user_id]
    user_id = current_user.id

    @message.message_headers
      .new(header_params(user_id, other_id))

    if @message.save
      redirect_to conversation_user_messages_url(params[:user_id])
    else
      flash.now[:errors] = @message.errors.full_messages
      render :new
    end
  end

  def conversation
    user_id = current_user.id
    other_id = params[:user_id]
    @other_username = User.find(other_id).username

    @messages = MessageHeader.find_by_sql ["
      SELECT message_headers.is_sent, messages.body
      FROM message_headers JOIN messages
      ON message_headers.message_id = messages.id
      WHERE user_id = ? AND other_id = ?
      ", user_id, other_id]



  end

  def destroy

  end

  private

  #  id         :integer          not null, primary key
  #  user_id    :integer
  #  other_id   :integer
  #  message_id :integer
  #  is_sent    :boolean
  #  is_read    :boolean          default(FALSE)

  def header_params(user_id, other_id)
    user_header = {
      user_id: user_id,
      other_id: other_id,
      is_sent: true,
      is_read: true
    }
    other_header = {
      user_id: other_id,
      other_id: user_id,
      is_sent: false,
      is_read: false
    }

    [user_header, other_header]
  end

end
