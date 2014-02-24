class Notification < ActiveRecord::Base
  attr_accessible :is_read, :receiver_id, :trigger_id, :type

  belongs_to :receiver,
  class_name: "User",
  foreign_key: :receiver_id

  belongs_to :triggering_user,
  class_name: "User",
  foreign_key: :trigger_id


end
