class NotificationsController < ApplicationController

  def read
    current_user.received_notifications.where(:is_read => false).each do |note|
      note.update_attributes!({:is_read => true})
    end

    head :ok
  end
end
