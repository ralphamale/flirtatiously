# == Schema Information
#
# Table name: messages
#
#  id         :integer          not null, primary key
#  body       :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Message < ActiveRecord::Base
  attr_accessible :body
  validates :body, presence: true

  has_many :message_headers, dependent: :destroy,
  foreign_key: :message_id

end
