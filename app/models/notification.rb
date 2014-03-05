# == Schema Information
#
# Table name: notifications
#
#  id          :integer          not null, primary key
#  receiver_id :integer
#  trigger_id  :integer
#  status_type :integer
#  is_read     :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Notification < ActiveRecord::Base
  attr_accessible :is_read, :receiver_id, :trigger_id, :status_type

  belongs_to :receiver,
  class_name: "User",
  foreign_key: :receiver_id

  belongs_to :triggering_user,
  class_name: "User",
  foreign_key: :trigger_id

  has_many :triggerer_photos,
  through: :triggering_user,
  source: :photos

  has_one :triggering_profile,
  through: :triggering_user,
  source: :profile

end
