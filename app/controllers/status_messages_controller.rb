class StatusMessagesController < ApplicationController
  before_filter :require_logged_in!

  def index
    @status_messages = StatusMessage
      .joins("INNER JOIN users ON status_messages.user_id = users.id
      INNER JOIN profiles ON profiles.user_id =
      users.id")
      .select('status_messages.body AS body,
      users.username AS username, profiles.id AS p_id,
      status_messages.created_at AS created_at')
      .where("users.id != ?", current_user.id)
      .order("status_messages.created_at DESC")
  end
  def create
    @status_message = current_user.status_messages.new(params[:status_message])

    if current_user.save
      render :partial => @status_message, layout: false
    else
      flash.now[:errors] = "Status unsuccessfully created."
      redirect_to profiles_url
    end

  end
end
