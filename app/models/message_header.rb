# == Schema Information
#
# Table name: message_headers
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  other_id   :integer
#  message_id :integer
#  is_sent    :boolean
#  is_read    :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class MessageHeader < ActiveRecord::Base
  attr_accessible :is_read, :is_sent, :message_id, :other_id, :user_id
  validates :is_sent, :is_read, inclusion: [true, false]
  validates :user, presence: true
  validates :message, presence: true

  belongs_to :user,
  inverse_of: :message_headers,
  foreign_key: :user_id

  belongs_to :other_user,
  class_name: "User",
  foreign_key: :other_id

  belongs_to :message, inverse_of: :message_headers,
  foreign_key: :message_id

end
