class NotificationsController < ApplicationController

  def index
    @notifications = current_user.received_notifications.order("created_at DESC")
  end

  def read
    current_user.received_notifications.where(:is_read => false).each do |note|
      note.update_attributes!({:is_read => true})
    end

    head :ok
  end
end
