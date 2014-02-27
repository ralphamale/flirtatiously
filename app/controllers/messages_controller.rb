class MessagesController < ApplicationController
  before_filter :require_current_user!
  before_filter :require_not_current_users_page!, only: [:conversation, :new, :create]

  def index
    @messages = Message.joins("INNER JOIN message_headers ON messages.id = message_headers.message_id INNER JOIN users ON message_headers.other_id = users.id").select("message_headers.other_id AS recipient_id, users.username AS recipient_username, messages.body AS body, messages.created_at AS sent_date, message_headers.is_sent AS is_sent").where("message_headers.user_id = ?", current_user.id).order("messages.created_at DESC")
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
    #current_user.messages.new()

    @message = Message.new(params[:message])
    other_id = params[:user_id].to_i
    user_id = current_user.id

    puts user_id
    puts other_id
    puts @message.valid?

    puts "before message header declaration"
    puts header_params(user_id, other_id)
    @mh = @message.message_headers.new(header_params(user_id, other_id))
    puts @mh[0]
      puts @mh[0].valid?
      puts @mh[1]
      puts @mh[1].valid?


      @notification = Notification.create!({
        is_read: false,
        receiver_id: other_id,
        trigger_id: current_user.id,
        status_type: 1
        })

      puts "after valid before save"
    if @message.save

      if request.xhr?
        render json: @message
      else
        render json: @message.errors
      end


    else
      render :json => @message.errors.full_messages
    end
  end

  def sent
    @sent_messages = Message.joins("INNER JOIN message_headers ON messages.id = message_headers.message_id INNER JOIN users ON message_headers.other_id = users.id").select("message_headers.other_id AS recipient_id, users.username AS recipient_username, messages.body AS body, messages.created_at AS sent_date").where("message_headers.is_sent = true AND message_headers.user_id = ?", current_user.id).order("messages.created_at DESC")
  end

  def conversation
    #whenever u show, u wanna mark IS READ.
    user_id = current_user.id
    other_id = params[:user_id]
    @other_user = User.find(other_id)
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
